FROM ubuntu:24.04

# Update current packages
# Install new packages
# Clean up after install to reduce image size
RUN apt update && apt upgrade -y && \
    apt install -y git curl zsh build-essential vim bash dirmngr gpg gawk && \
    apt clean && rm -rf /var/lib/apt/lists/*

# For security reason, it's best to use non-root user, and the ubuntu image come wiith default ubuntu by default
USER ubuntu

ENV ASDF_VERSION=0.15.0 \
    NODE_VERSION=22.12.0 \
    PATH=${PATH}:~/.local/bin

## Install oh-my-zsh
RUN curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh -s

## Install asdf
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v${ASDF_VERSION} && \
    echo '. "${HOME}/.asdf/asdf.sh"' >> ~/.zshrc
#    source ~/.zshrc

#RUN asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git && \
#    asdf install nodejs latest && \
#    asdf global nodejs latest

WORKDIR /workspace
