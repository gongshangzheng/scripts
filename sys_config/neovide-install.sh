#!/usr/bin/env sh
# reference: [[https://neovide.dev/installation.html][Installation - Neovide]]
sudo apt install -y curl \
    gnupg ca-certificates git \
    gcc-multilib g++-multilib cmake libssl-dev pkg-config \
    libfreetype6-dev libasound2-dev libexpat1-dev libxcb-composite0-dev \
    libbz2-dev libsndio-dev freeglut3-dev libxmu-dev libxi-dev libfontconfig1-dev \
    libxcursor-dev
curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh
cargo install --git https://github.com/neovide/neovide --force
