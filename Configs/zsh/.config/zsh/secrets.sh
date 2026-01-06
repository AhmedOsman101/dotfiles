#!/usr/bin/env bash

export GEMINI_API_KEY="$(pass show gemini)"
export GOOGLE_GENERATIVE_AI_API_KEY="${GEMINI_API_KEY}"

export OPENAI_API_KEY="$(pass show openai)"

export GITHUB_TOKEN="$(pass show github/tokens/1)"

export ADVENT_OF_CODE_SESSION="$(pass show advent-of-code)"
