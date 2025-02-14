#!/usr/bin/env sh

cd /tmp
wget https://git.savannah.gnu.org/cgit/guix.git/plain/etc/guix-install.sh
chmod +x guix-install.sh
sudo ./guix-install.sh
guix pull # update guix channe
# guix pull --news # show new update
guix upgrade

# to resolve the porblem of LC_ALL cannot change locale
sudo guix install glibc-locales
# add the following line
# GUIX_LOCPATH=$HOME/.guix-profile/lib/locale
sudo echo "GUIX_LOCPATH=$HOME/.guix-profile/lib/locale" >> /root/profile
# guix-daemon
sudo -i guix pull
sudo systemctl restart guix-daemon.service
sudo systemctl status guix-daemon.service
