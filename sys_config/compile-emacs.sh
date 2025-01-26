version=$29.2
mkdir ~/applications/emacs_build
cd ~/applications/emacs_build
wget -c https://ftpmirror.gnu.org/emacs/emacs-$version.tar.gz
wget -c https://ftpmirror.gnu.org/emacs/emacs-$version.tar.gz.sig
gpg --keyserver keyserver.ubuntu.com --recv-keys \
    17E90D521672C04631B1183EE78DAE0F3115E06B
gpg --verify emacs-$version.tar.gz.sig
tar xvfz emacs-$version.tar.gz
cd emacs-$version
