# config.nu
#
# Installed by:
# version = "0.103.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

alias cls = clear

$env.config.color_config.string = "ligr"
$env.config.color_config.binary = "ligr"
$env.config.color_config.block = "ligr"
$env.config.color_config.cell-path = "ligr"
$env.config.color_config.duration = "ligr"
$env.config.color_config.nothing = "ligr"
$env.config.color_config.range = "ligr"
$env.config.color_config.record = "ligr"
$env.config.color_config.separator = "ligr"
$env.config.color_config.float = "y"
$env.config.color_config.int = "y"
$env.config.color_config.nothing = "ligrb"

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
