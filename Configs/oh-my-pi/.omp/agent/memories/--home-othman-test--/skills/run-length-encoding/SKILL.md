# Run-Length Encoding with Escaping

Implement `encode_complex_string` in Python:

## Rules
1. Runs of consecutive chars (length > 1) become `char + count`; single chars stay bare.
2. Escape digits in input with '#' prefix (e.g., '3' -> '#3').
3. Escape '#' in input by doubling ('#' -> '##').
4. Apply escaping during the encoding pass, not after, so appended counts cannot be mistaken for escaped input digits.

## Pitfall
Post-hoc escaping creates ambiguity between 'a#3' (escaped digit 3) and 'a3' (count 3). Integrate escaping into the single encoding loop.

## Verification
Round-trip with a decoder that consumes '#' as an escape marker followed by one literal char, then reads count digits.
