#!/usr/bin/env -S kitty +launch
from kitty.config import commented_out_default_config as conf

file_path = 'default.conf'
with open(file_path, 'w', encoding='utf-8') as f:
    f.write(conf())
print(file_path)
