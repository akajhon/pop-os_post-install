#!/usr/bin/env bash
#
# post_install.sh - Instalar e configura programas no Pop!_OS (20.04 LTS ou superior)
#
# ------------------------------------------------------------------------ #
#
# COMO USAR?
#   $ chmod +x pos-os-postinstall.sh
#   $ ./pos-os-postinstall.sh
#
# ----------------------------- VARIÁVEIS ----------------------------- #

##URLS

URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_DRACULA_THEME="https://github.com/dracula/gtk/archive/master.zip"
URL_DRACULA_ICONTHEME="https://github.com/dracula/gtk/files/5214870/Dracula.zip"
URL_CADMUS="https://github.com/josh-richardson/cadmus/releases/download/0.0.3/cadmus.deb"
URL_NERD_FONT = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraMono.zip"

##DIRETÓRIOS E ARQUIVOS

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"
mkdir "$DIRETORIO_DOWNLOADS"

#CORES

VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'


#FUNÇÕES

# Atualizando repositório e fazendo atualização do sistema

apt_update(){
  sudo apt update && sudo apt dist-upgrade -y
}

# -------------------------------------------------------------------------------- #
# -------------------------------TESTES E REQUISITOS----------------------------------------- #

# Internet conectando?
testes_internet(){
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
  echo -e "${VERMELHO}[ERROR] - Seu computador não tem conexão com a Internet. Verifique a rede.${SEM_COR}"
  exit 1
else
  echo -e "${VERDE}[INFO] - Conexão com a Internet funcionando normalmente.${SEM_COR}"
fi
}

# ------------------------------------------------------------------------------ #


## Removendo travas eventuais do apt ##
travas_apt(){
  sudo rm /var/lib/dpkg/lock-frontend
  sudo rm /var/cache/apt/archives/lock
}

## Adicionando/Confirmando arquitetura de 32 bits ##
add_archi386(){
sudo dpkg --add-architecture i386
}
## Atualizando o repositório ##
just_apt_update(){
sudo apt update -y
}

##Adicionando Repositórios
add_repos(){
sudo add-apt-repository ppa:transmissionbt/ppa
sudo add-apt-repository ppa:agornostal/ulauncher
sudo add-apt-repository ppa:alexlarsson/flatpak
}


##DEB SOFTWARES TO INSTALL

PROGRAMAS_PARA_INSTALAR=(
  snapd
  ratbagd
  gparted
  timeshift
  virtualbox
  gufw
  synaptic
  vlc
  gnome-sushi 
  folder-color
  git
  ubuntu-restricted-extras
  zsh
  vim
  neovim
  tlp 
  tlp-rdw
  htop
  neofetch
  gnome-tweaks
  ulauncher
  xclip
  transmission
  terminator
  nodejs
  npm
)

# ---------------------------------------------------------------------- #

## Download e instalaçao de programas externos ##

install_debs(){

echo -e "${VERDE}[INFO] - Baixando pacotes .deb${SEM_COR}"

wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_CADMUS"       -P "$DIRETORIO_DOWNLOADS"


## Instalando pacotes .deb baixados na sessão anterior ##
echo -e "${VERDE}[INFO] - Instalando pacotes .deb baixados${SEM_COR}"
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

# Instalar programas no apt
echo -e "${VERDE}[INFO] - Instalando pacotes apt do repositório${SEM_COR}"

for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    sudo apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done
}

## Instalando pacotes Flatpak ##
install_flatpaks(){

  echo -e "${VERDE}[INFO] - Instalando pacotes flatpak${SEM_COR}"

flatpak install flathub com.discordapp.Discord -y
flatpak install flathub com.uploadedlobster.peek -y
flatpak install flathub org.kde.okular -y
flatpak install flathub org.videolan.VLC -y
flatpak install flathub md.obsidian.Obsidian -y
flatpak install flathub com.spotify.Client -y
flatpak install flathub com.bitwarden.desktop -y
flatpak install flathub org.onlyoffice.desktopeditors -y
flatpak install flathub org.flameshot.Flameshot -y
flatpak install flathub org.gnome.Connections -y
flatpak install flathub cc.arduino.IDE2 -y
}

## Instalando pacotes Snap ##

install_snaps(){

echo -e "${VERDE}[INFO] - Instalando pacotes snap${SEM_COR}"

sudo snap install pycharm-community --classic 

}

install_vscode(){
echo -e "${VERDE}[INFO] - Instalando VSCode! :)${SEM_COR}"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https -y
sudo apt-get update
sudo apt-get install code -y 
code --install-extension Shan.code-settings-sync
}

conf_theme(){
  echo -e "${VERDE}[INFO] - Configurando Dracula Theme no Gnome! :)${SEM_COR}"
	#Download Dracula Themes
	wget -c "$URL_DRACULA_THEME"       -P "$DIRETORIO_DOWNLOADS"
	wget -c "$URL_DRACULA_ICONTHEME"       -P "$DIRETORIO_DOWNLOADS"
	
	#Moving to /usr/share/themes and /usr/share/icons
	unzip gtk-master.zip -d /usr/share/themes
	unzip Dracula.zip -d /usr/share/icons 
	
	#Gnome Theme
	gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
	gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
	#Icons
	gsettings set org.gnome.desktop.interface icon-theme "Dracula"

  #Download Dracula gnome-Terminal
	git clone https://github.com/dracula/gnome-terminal "$DIRETORIO_DOWNLOADS"
  chmod +x "$HOME/Downloads/programas/gnome-terminal/install.sh"
	"$HOME/Downloads/programas/gnome-terminal/install.sh"
}

conf_terminal(){
  echo -e "${VERDE}[INFO] - Configurando Terminal! :)${SEM_COR}"

  #Installing NVM
  sh -c "$(curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh)"

	#Installing OhMyZSH
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  chsh -s /bin/zsh
	
	#INstalling ZINIT
	sh -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
	zinit self-update
	
	#Installing Spaceship theme
	git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
	ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
	
	#Configs
	sudo mv zhrc .zhrc
	sudo mv -f .zhrc "/home/$USERNAME/"
	export alias pbcopy='xclip -selection clipboard'
	export alias pbpaste='xclip -selection clipboard -o'
	source ~/.zshrc
	echo "All the OhMyZSH configurations are Done. Please Reboot."	
}

conf_terminator(){
echo -e "${VERDE}[INFO] - Adicionando Dracula Theme no Terminator! :)${SEM_COR}"
cat <<EOF >  ~/.config/terminator/config
[global_config]
  title_transmit_bg_color = "#ad7fa8"
[keybindings]
  close_term = <Primary>w
  close_window = <Primary>q
  new_tab = <Primary>t
  new_window = <Primary>i
  paste = <Primary>v
  split_horiz = <Primary>e
  split_vert = <Primary>d
  switch_to_tab_1 = <Primary>1
  switch_to_tab_10 = <Primary>0
  switch_to_tab_2 = <Primary>2
  switch_to_tab_3 = <Primary>3
  switch_to_tab_4 = <Primary>4
  switch_to_tab_5 = <Primary>5
  switch_to_tab_6 = <Primary>6
[layouts]
  [[default]]
    [[[child1]]]
      parent = window0
      type = Terminal
    [[[window0]]]
      parent = ""
      type = Window
[plugins]
[profiles]
  [[default]]
    cursor_color = "#aaaaaa"
EOF


cat <<EOF >>  ~/.config/terminator/config
[[Dracula]]
    background_color = "#1e1f29"
    background_darkness = 0.88
    background_type = transparent
    copy_on_selection = True
    cursor_color = "#bbbbbb"
    foreground_color = "#f8f8f2"
    palette = "#000000:#ff5555:#50fa7b:#f1fa8c:#bd93f9:#ff79c6:#8be9fd:#bbbbbb:#555555:#ff5555:#50fa7b:#f1fa8c:#bd93f9:#ff79c6:#8be9fd:#ffffff"
    scrollback_infinite = True
EOF
}

conf_nvim(){
  echo -e "${VERDE}[INFO] - Configurando AstroVIM! :)${SEM_COR}"
  #Configurando NerdFont
  wget -c "$URL_NERD_FONT"       -P "$DIRETORIO_DOWNLOADS"
  sudo mkdir "/home/$USERNAME/.fonts"
  unzip "$DIRETORIO_DOWNLOADS/FiraMono.zip" -d "/home/$USERNAME/.fonts"

  #Backup NVIM atual
  mv ~/.config/nvim ~/.config/nvimbackup

  #Baixando AstroVim
  git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
  nvim +PackerSync
}


# -------------------------------------------------------------------------- #
# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #


## Finalização, atualização e limpeza##

system_clean(){
echo -e "${VERDE}[INFO] - Limpando sistema... :)${SEM_COR}"
apt_update -y
flatpak update -y
sudo apt autoclean -y
sudo apt autoremove -y
nautilus -q
}


# -------------------------------------------------------------------------- #
# ----------------------------- CONFIGS EXTRAS ----------------------------- #

extra_config(){
echo -e "${VERDE}[INFO] - Configurações extras! :)${SEM_COR}"
#enabling workspaces for both screens
gsettings set org.gnome.mutter workspaces-only-on-primary false

#Ulauncher Dracula Theme
git clone https://github.com/dracula/ulauncher.git ~/.config/ulauncher/user-themes/dracula-ulauncher

#Ngrok
sh -c "$(curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo deb https://ngrok-agent.s3.amazonaws.com buster main | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok)"
}

# -------------------------------------------------------------------------------- #
# -------------------------------EXECUÇÃO----------------------------------------- #

if [[ "$1" == "initial" ]]; then
  travas_apt
  testes_internet
  travas_apt
  apt_update
  travas_apt
  add_archi386
  just_apt_update
  add_repos
  just_apt_update
elif [[ "$1" == "install" ]]; then
  install_debs
  install_flatpaks
  install_snaps
  apt_update
  system_clean
elif [[ "$1" == "config" ]]; then
  conf_terminal
  conf_terminator
  conf_theme
  conf_nvim
  extra_config
  apt_update
  system_clean
else
  echo -e "${VERMELHO}[INFO] - Argumento inválido! :)${SEM_COR}"
  exit
fi

## Finalização
  echo -e "${VERDE}[INFO] - Script finalizado, instalação concluída! :)${SEM_COR}"
