#!/usr/bin/env bash

GEMINI_API_KEY="$(pass show gemini)"
GOOGLE_GENERATIVE_AI_API_KEY="${GEMINI_API_KEY}"

OPENAI_API_KEY="$(pass show openai)"

GITHUB_TOKEN="$(pass show github/tokens/1)"

ADVENT_OF_CODE_SESSION="$(pass show advent-of-code)"

ANTHROPIC_API_KEY="$(pass show agent-router)"

export GEMINI_API_KEY \
  GOOGLE_GENERATIVE_AI_API_KEY \
  OPENAI_API_KEY \
  GITHUB_TOKEN \
  ADVENT_OF_CODE_SESSION \
  ANTHROPIC_AUTH_TOKEN \
  ANTHROPIC_API_KEY
