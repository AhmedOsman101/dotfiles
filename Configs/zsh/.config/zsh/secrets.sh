#!/usr/bin/env bash
# shellcheck disable=2034

_allChecked=true
_vars=(
  GEMINI_API_KEY
  GOOGLE_GENERATIVE_AI_API_KEY
  OPENAI_API_KEY
  GITHUB_TOKEN
  ADVENT_OF_CODE_SESSION
  ANTHROPIC_API_KEY
  AI_GATEWAY_API_KEY
  CONTEXT7_API_KEY
  OBSIDIAN_API_KEY
  OPENROUTER_API_KEY
  ZAI_API_KEY
  ANILIST_TOKEN
  FEATHERLESS_API_KEY
  HF_TOKEN
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

GEMINI_API_KEY="$(pass show gemini)"
GOOGLE_GENERATIVE_AI_API_KEY="${GEMINI_API_KEY}"

OPENAI_API_KEY="$(pass show openai)"

GITHUB_TOKEN="$(pass show github/tokens/1)"

ADVENT_OF_CODE_SESSION="$(pass show advent-of-code)"

ANTHROPIC_API_KEY="$(pass show agent-router)"

AI_GATEWAY_API_KEY="$(pass show vercel/ai-gateway)"

CONTEXT7_API_KEY="$(pass show context7)"

OBSIDIAN_API_KEY="$(pass show obsidian/api-key)"

OPENROUTER_API_KEY="$(pass show openrouter)"

ZAI_API_KEY="$(pass show z.ai)"

ANILIST_TOKEN="$(pass show anilist/access-token)"

FEATHERLESS_API_KEY="$(pass show featherless | head -1)"

HF_TOKEN="$(pass show hugging-face)"

export "${_vars[@]}"

unset _vars _allChecked
