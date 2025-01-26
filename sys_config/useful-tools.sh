sudo apt update
sudo apt install -y gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
sudo apt install fzf bat tldr zoxide
curl -sS https://starship.rs/install.sh | sh
sudo apt install fd-find
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh #install rust
# sudo apt install graphviz
sudo apt install exuberant-ctags
curl -LsSf https://astral.sh/uv/install.sh | sh #uv python
sudo apt install xdotool
