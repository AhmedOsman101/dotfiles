#compdef deno
function _clap_dynamic_completer_deno() {
  local _CLAP_COMPLETE_INDEX=$(expr $CURRENT - 1)
  local _CLAP_IFS=$'\n'

  local completions=("${(@f)$( \
      _CLAP_IFS="$_CLAP_IFS" \
      _CLAP_COMPLETE_INDEX="$_CLAP_COMPLETE_INDEX" \
      COMPLETE="zsh" \
      deno -- "${words[@]}" 2>/dev/null \
  )}")

  if [[ -n $completions ]]; then
      _describe -V 'values' completions -o nosort
  fi
}

compdef _clap_dynamic_completer_deno deno
