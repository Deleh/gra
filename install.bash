#!/usr/bin/env bash

# Adds $1 to ~/.bashrc if not already present
function _add_to_config {
    if ! grep "$1" ~/.bashrc > /dev/null; then
        echo "$1" >> ~/.bashrc
    fi
}

# Link files
basedir="$(dirname "$(realpath "$0")")"
mkdir -p ~/.local/{bin,share/bash-completion/completions}
ln -frs "${basedir}/gra" ~/.local/bin/gra
echo "Created link '~/.local/bin/gra'"
ln -frs "${basedir}/gra_completion.bash" ~/.local/share/bash-completion/completions/gra
echo "Created link '~/.local/share/bash-completion/completions/gra'"

# Modify bashrc
touch ~/.bashrc
_add_to_config "export PATH=\$PATH:${HOME}/.local/bin"
_add_to_config "source ${HOME}/.local/share/bash-completion/completions/gra"
echo "Updated '~/.bashrc'"

echo
echo "Source ~/.bashrc to use gra"
echo "To update gra in future execute 'git pull' in '${basedir}'"
