version="29.2"
build_dir="$HOME/applications/emacs_build"
source_file="emacs-$version.tar.gz"
sig_file="emacs-$version.tar.gz.sig"

# Create build directory
mkdir -p "$build_dir"
cd "$build_dir" || exit

# Download files if they don't exist
if [ ! -f "$source_file" ]; then
    wget -c "https://ftpmirror.gnu.org/emacs/$source_file"
fi

if [ ! -f "$sig_file" ]; then
    wget -c "https://ftpmirror.gnu.org/emacs/$sig_file"
fi

# Verify signature
gpg --keyserver keyserver.ubuntu.com --recv-keys \
    17E90D521672C04631B1183EE78DAE0F3115E06B
gpg --verify "$sig_file"

# Extract source
if [ ! -d "emacs-$version" ]; then
    tar xvfz "$source_file"
fi

cd "emacs-$version" || exit

# Remove existing Emacs installation
sudo apt-get remove --purge emacs emacs-common emacs-gtk emacs-lucid

# Install build dependencies including X toolkit
sudo apt-get install -y build-essential libx11-dev libxpm-dev \
    libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev \
    libncurses-dev libxpm-dev libgnutls28-dev libmagickwand-dev \
    libtree-sitter-dev libgccjit-12-dev libjansson-dev \
    libmailutils-dev mailutils libsqlite3-dev

# Configure with recommended options
./configure --with-native-compilation=aot \
            --with-tree-sitter \
            --with-gif \
            --with-png \
            --with-jpeg \
            --with-rsvg \
            --with-tiff \
            --with-imagemagick \
            --with-x-toolkit=gtk \
            --with-json \
            --with-mailutils

# Build and install
make clean
make -j$(nproc)
sudo make install

# Verify installation
emacs --version
