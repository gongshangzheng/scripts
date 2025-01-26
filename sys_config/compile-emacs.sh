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

# Install build dependencies
sudo apt-get build-dep -y emacs

# Configure with recommended options
./configure --with-native-compilation=aot \
            --with-tree-sitter \
            --with-gif \
            --with-png \
            --with-jpeg \
            --with-rsvg \
            --with-tiff \
            --with-imagemagick \
            --with-x-toolkit=lucid \
            --with-json \
            --with-mailutils

# Build and install
make clean
make -j$(nproc)
sudo make install

# Verify installation
emacs --version
