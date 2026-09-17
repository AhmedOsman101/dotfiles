encode_complex_string("aaab") -> "aaa3b"
encode_complex_string("a#3") -> "a##'#3" style: '#' -> '##', '3' -> '#3', so "a###3"
encode_complex_string("###") -> "##" + run of '#' chars, each doubled: "####" (3 hashes -> '####' with count 3 => '####3')
