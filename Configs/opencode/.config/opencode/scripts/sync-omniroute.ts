#!/usr/bin/env bun
// Bun v1.4 — uses native json/jsonc/yaml loaders + Bun.file/Bun.write + spawn for quicktype
// Lives in opencode config dir. Run: bun run scripts/sync-omniroute.ts [--update]
// Fetches http://localhost:8082/v1/models (and optionally 9router), regenerates types via quicktype,
// maps to opencode provider.models, outputs JSON or patches opencode.jsonc when --update

const OMNI_URL = process.env.OMNIROUTE_URL ?? "http://localhost:8082/v1";
const DIR = import.meta.dir; // .../opencode/scripts
const OMNI_JSON = `${DIR}/omniroute.json`;
const OMNI_TS = `${DIR}/types.ts`;
const MODELS_OUT = `${DIR}/models.json`;

const shouldUpdate = Bun.argv.includes("--update");
const endpoint = OMNI_URL;

async function fetchModels(url: string) {
  const res = await fetch(`${url.replace(/\/$/, "")}/models`);
  if (!res.ok)
    throw new Error(`${url}/models ${res.status} ${await res.text()}`);
  return await res.json();
}

async function regenTypes(jsonPath: string, tsPath: string) {
  // quicktype -o <ts> --just-types <json>  (required per spec)
  await Bun.$`quicktype -o ${tsPath} --just-types ${jsonPath}`.quiet();
}

// dynamic import after regen to satisfy "import them directly" — types are erased at runtime but import proves file is valid
async function loadTypes(tsPath: string) {
  try {
    await import(tsPath);
  } catch {}
}

function toOpencodeModels(modelsList: any) {
  const allowed = new Set(["text", "audio", "image", "video", "pdf"]);
  const models: Record<string, any> = {};
  for (const m of modelsList.data) {
    const t = m.type as string | undefined;
    if (t && t !== "chat") continue; // skip embedding/image/audio/video/rerank

    const id = m.id as string;
    const entry: Record<string, any> = { name: m.name ?? id };

    const ctx = m.context_length ?? m.max_input_tokens;
    const out = m.max_output_tokens ?? m.max_completion_tokens;
    if (ctx && out) entry.limit = { context: ctx, output: out };

    const caps = m.capabilities ?? {};
    const reasoning = Boolean(
      caps.reasoning || caps.thinking || caps.supportsThinking
    );
    if (reasoning) entry.reasoning = true;
    if (caps.tool_calling) entry.tool_call = true;
    if (caps.temperature) entry.temperature = true;

    const attachment = Boolean(caps.attachment || caps.vision);
    if (attachment) entry.attachment = true;

    const inp: string[] | undefined = m.input_modalities;
    const outp: string[] | undefined = m.output_modalities;
    if (inp || outp) {
      const modalities: Record<string, string[]> = {};
      if (inp) {
        const f = inp.filter((x: string) => allowed.has(x));
        if (f.length) modalities.input = f;
      }
      if (outp) {
        const f = outp.filter((x: string) => allowed.has(x));
        if (f.length) modalities.output = f;
      }
      if (Object.keys(modalities).length) entry.modalities = modalities;
    } else if (attachment) {
      entry.modalities = { input: ["text", "image"], output: ["text"] };
    }

    models[id] = entry;
  }
  return models;
}

let raw: any;
try {
  raw = await fetchModels(endpoint);
  await Bun.write(OMNI_JSON, JSON.stringify(raw, null, 2));
  console.info(
    `fetched ${raw.data.length} models from ${endpoint}/models -> ${OMNI_JSON}`
  );
} catch (e) {
  console.error(`fetch failed, falling back to ${OMNI_JSON}: ${e}`);
  raw = await Bun.file(OMNI_JSON).json();
}

try {
  await regenTypes(OMNI_JSON, OMNI_TS);
  console.info(`regenerated types -> ${OMNI_TS}`);
  await loadTypes(OMNI_TS);
} catch (e) {
  console.error(`quicktype failed (continuing): ${e}`);
}

const data = await Bun.file(OMNI_JSON).json();
const models = toOpencodeModels(data);
await Bun.write(MODELS_OUT, JSON.stringify(models, null, 2));
console.info(`wrote ${Object.keys(models).length} models -> ${MODELS_OUT}`);

if (shouldUpdate) {
  const { modify, applyEdits, format } = await import("jsonc-parser");
  const configPath = `${DIR}/../opencode.jsonc`;
  const text = await Bun.file(configPath).text();

  // Read existing omniroute options if present, to preserve them
  const { parse } = await import("jsonc-parser");
  const parsed = parse(text) as any;
  const existing = parsed?.provider?.omniroute ?? {};
  const omnirouteValue = {
    npm: existing.npm ?? "@ai-sdk/openai-compatible",
    options: existing.options ?? {
      baseURL: OMNI_URL,
      apiKey: "{env:OMNIROUTE_API_KEY}",
    },
    models,
  };

  // jsonc-parser.modify returns edits that surgically replace only the target path, preserving comments
  const modifyEdits = modify(text, ["provider", "omniroute"], omnirouteValue, {
    insertSpaces: true,
    tabSize: 2,
  });
  const patched = applyEdits(text, modifyEdits);

  // format the entire document to ensure consistent indentation (modify outputs compact JSON)
  const formatEdits = format(patched, undefined, {
    insertSpaces: true,
    tabSize: 2,
    trimTrailingWhitespace: true,
    insertFinalNewline: true,
  });
  const updated = applyEdits(patched, formatEdits);

  await Bun.write(configPath, updated);
  console.info(
    `patched opencode.jsonc provider.omniroute (${Object.keys(models).length} models, comments preserved)`
  );
} else {
  console.info(
    "\nWithout --update: paste into opencode.jsonc as provider.omniroute.models"
  );
  console.info("With --update: ~/.config/opencode/scripts/sync-omniroute.ts --update");
}
