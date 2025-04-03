#!/bin/bash
#!/bin/bash
# ================================================================
#   Improved Doom Emacs installer with multi-distro support
#   Supports: Debian/Ubuntu, Arch Linux
#   Features: Auto-detect distro, dependency checks, fallback installs
# ================================================================

set -euo pipefail

# Distro detection
if grep -qEi 'debian|ubuntu' /etc/os-release; then
    DISTRO="debian"
elif grep -q 'Arch Linux' /etc/os-release; then
    DISTRO="arch"
else
    echo "Unsupported distribution"
    exit 1
fi

# Dependency installer function
install_pkg() {
    local pkg=$1
    echo "Installing $pkg..."

    case $DISTRO in
        debian)
            sudo apt-get install -y "$pkg" || {
                echo "Failed to install $pkg"
                return 1
            }
            ;;
        arch)
            sudo pacman -S --noconfirm "$pkg" || {
                echo "Failed to install $pkg"
                return 1
            }
            ;;
    esac
}

# Install basic dependencies
case $DISTRO in
    debian)
        sudo apt-get update
        for pkg in libtool libvterm-dev libsqlite3-dev ripgrep fd-find mpv; do
            install_pkg "$pkg" || true
        done

        # Handle fd-find/ripgrep for older Ubuntu
        if ! command -v fd &> /dev/null; then
            echo "Installing fd-find alternative..."
            wget -O fd.deb "https://github.com/sharkdp/fd/releases/download/v8.2.1/fd_8.2.1_amd64.d
            sudo dpkg -i fd.deb || sudo apt-get install -f -y
        fi
        ;;
    arch)
        for pkg in libtool libvterm sqlite ripgrep fd mpv; do
            install_pkg "$pkg" || true
        done
        ;;
esac

# Install Emacs
if ! command -v emacs &> /dev/null; then
    case $DISTRO in
        debian)
            sudo add-apt-repository ppa:kelleyk/emacs -y
            sudo apt-get update
            install_pkg emacs
            ;;
        arch)
            install_pkg emacs
            ;;
    esac
fi

# Clone Doom Emacs
if [ ! -d "$HOME/.emacs.d" ]; then
    git clone --depth 1 https://github.com/hlissner/doom-emacs "$HOME/.emacs.d" || {
        echo "Failed to clone Doom Emacs"
        exit 1
    }
fi

# Install Doom
if [ -d "$HOME/.emacs.d" ]; then
    "$HOME/.emacs.d/bin/doom" install || {
        echo "Doom install failed"
        exit 1
    }

    "$HOME/.emacs.d/bin/doom" sync || {
        echo "Doom sync failed"
        exit 1
    }
fi

# Optional components
if [ "$DISTRO" = "debian" ]; then
    install_pkg librime-dev || echo "Skipping librime-dev"
fi

# Install yt-dlp if directory exists
if [ -d "$HOME/scripts/py_scripts" ]; then
    cd "$HOME/scripts/py_scripts" || exit
    if command -v uv &> /dev/null; then
        uv add yt-dlp
        uv pip install -U --pre "yt-dlp[default]"
    else
        pip install -U --pre "yt-dlp[default]"
    fi
fi

echo "Doom Emacs installation complete!"
