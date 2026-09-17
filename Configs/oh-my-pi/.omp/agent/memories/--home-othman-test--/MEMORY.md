# Run-Length Encoding with Escaping

User requested a Python function `encode_complex_string` implementing run-length encoding with constraints:
- Consecutive characters replaced by char + count; single chars have no count suffix.
- Digits are escaped with '#'.
- '#' is doubled to '##'.

## Key Pitfall
Ambiguity between escaped characters (e.g., 'a#3') and appended counts (e.g., 'a3'). The escaping order must be resolved before counts are applied — escaping must be integrated into or precede the encoding loop so output remains unambiguously parseable.

## Decision
Handle escaping consistently: digits and hashes are escaped as part of the encoding pass so appended counts can never be confused with literal digits in the input.
