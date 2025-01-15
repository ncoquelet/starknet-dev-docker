#!/bin/bash

install_asdf() {
  local version="$1"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v${version}
  echo '. "${HOME}/.asdf/asdf.sh"' >> ~/.zshrc
  . "$HOME/.asdf/asdf.sh"
}

install_asdf_plugin() {
    local plugin_name="$1"
    local plugin_repo="$2"
    local plugin_version="$3"
    if [ -z "$plugin_name" ]; then
        echo "Error: Plugin name is required"
        return 1
    fi
    asdf plugin add $plugin_name $plugin_repo
    asdf install $plugin_name $plugin_version
    asdf global $plugin_name $plugin_version
}