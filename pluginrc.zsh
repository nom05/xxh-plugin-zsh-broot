# This script will be executed ON THE HOST when you connect to the host.
# Put here your functions, environment variables, aliases and whatever you need.

CURR_DIR="$(cd "$(dirname "$0")" && pwd)"
plugin_name='xxh-plugin-zsh-broot'

export PATH=$CURR_DIR/bin:$PATH
fpath=($CURR_DIR/completions $fpath)
