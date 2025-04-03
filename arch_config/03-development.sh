sudo pacman -S --needed git base-devel cmake make
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

sudo pacman -S xorg-xprop
sudo pacman -S qt5-base qt5-tools
