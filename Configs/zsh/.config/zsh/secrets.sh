#!/usr/bin/env bash
# shellcheck disable=2034

_allChecked=true
_vars=(
  ADVENT_OF_CODE_SESSION
  AI_GATEWAY_API_KEY
  ANILIST_TOKEN
  ANTHROPIC_API_KEY
  CONTEXT7_API_KEY
  FEATHERLESS_API_KEY
  GEMINI_API_KEY
  GITHUB_TOKEN
  GOOGLE_GENERATIVE_AI_API_KEY
  HF_TOKEN
  KIRO_PROXY_API_KEY
  NVIDIA_API_KEY
  OBSIDIAN_API_KEY
  OPENAI_API_KEY
  OPENROUTER_API_KEY
  ZAI_API_KEY
)

for var in "${_vars[@]}"; do
  # shellcheck disable=2296
  if [[ -z "${(P)var}" ]]; then # zsh style variable variables
    _allChecked=false
    break
  fi
done

if ${_allChecked}; then
  unset _vars _allChecked
  return 0
fi

ADVENT_OF_CODE_SESSION="$(pass show advent-of-code)"
AI_GATEWAY_API_KEY="$(pass show vercel/ai-gateway)"
ANILIST_TOKEN="$(pass show anilist/access-token)"
ANTHROPIC_API_KEY="$(pass show agent-router)"
CONTEXT7_API_KEY="$(pass show context7)"
FEATHERLESS_API_KEY="$(pass show featherless | head -1)"
GEMINI_API_KEY="$(pass show gemini)"
GITHUB_TOKEN="$(pass show github/tokens/main | head -1)"
GOOGLE_GENERATIVE_AI_API_KEY="${GEMINI_API_KEY}"
HF_TOKEN="$(pass show hugging-face)"
KIRO_PROXY_API_KEY="$(pass show kiro)"
NVIDIA_API_KEY="$(pass show nvidia/api-key)"
OBSIDIAN_API_KEY="$(pass show obsidian/api-key)"
OPENAI_API_KEY="$(pass show openai | head -1)"
OPENROUTER_API_KEY="$(pass show openrouter)"
ZAI_API_KEY="$(pass show z.ai)"

export "${_vars[@]}"

unset _vars _allChecked
