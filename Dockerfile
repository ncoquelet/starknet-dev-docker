FROM ubuntu:24.04

COPY utils.sh /usr/local/bin/

# Update current packages
# Install new packages
# Clean up after install to reduce image size
RUN apt update && apt upgrade -y && \
    apt install -y git curl zsh build-essential vim bash dirmngr gpg gawk && \
    apt clean && rm -rf /var/lib/apt/lists/* && \
    chmod +x /usr/local/bin/utils.sh

# For security reason, it's best to use non-root user, and the ubuntu image come wiith default ubuntu by default
# For security reason, it's best to use non-root user, and the ubuntu image come wiith default ubuntu by default
RUN usermod --login appuser --move-home --home /home/appuser --shell /bin/zsh ubuntu && \
    groupmod --new-name appuser ubuntu
USER appuser

ENV ASDF_VERSION=0.15.0 \
    ASDF_DIR=/home/appuser/.asdf \
    NODE_VERSION=22.12.0 \
    PATH=$PATH:/home/appuser/.local/bin

## Install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## Install asdf
RUN . /usr/local/bin/utils.sh && \
    install_asdf $ASDF_VERSION && \
    install_asdf_plugin nodejs https://github.com/asdf-vm/asdf-nodejs.git $NODE_VERSION && \
    install_asdf_plugin yarn https://github.com/twuni/asdf-yarn.git latest && \
    install_asdf_plugin rust https://github.com/code-lever/asdf-rust.git latest && \
    install_asdf_plugin scarb  https://github.com/software-mansion/asdf-scarb.git latest && \
    install_asdf_plugin starkli https://github.com/ptisserand/asdf-starkli latest && \
    install_asdf_plugin starknet-foundry https://github.com/foundry-rs/asdf-starknet-foundry.git latest && \
    install_asdf_plugin starknet-devnet https://github.com/ptisserand/asdf-starknet-devnet latest

WORKDIR /workspace
