```bash
  _____              _____          _     _____           _        _ _ 
 |  __ \            |  __ \        | |   |_   _|         | |      | | |
 | |__) |__  _ __   | |__) |__  ___| |_    | |  _ __  ___| |_ __ _| | |
 |  ___/ _ \| '_ \  |  ___/ _ \/ __| __|   | | | '_ \/ __| __/ _` | | |
 | |  | (_) | |_) | | |  | (_) \__ \ |_   _| |_| | | \__ \ || (_| | | |
 |_|   \___/| .__/  |_|   \___/|___/\__| |_____|_| |_|___/\__\__,_|_|_|
            | |                                                        
            |_|                                                                            
```

Script Desenvolvido para configuração do Pop_OS após uma nova instalação. As Principais funções são:

- [x] Instalação de pacotes .DEB, FLAT e SNAP
- [x] Configuração do Tema Dracula no Gnome
- [x] Configuração do Tema Dracula no Terminal
- [x] Instalação do ZSH
- [x] Instalação do NerdFonts
- [x] Instalação e Configuração do AstroVim para Neovim

***

Clone o projeto

```bash
  https://github.com/akajhon/pop-os-postinstall
```

Entre no diretório do projeto

```bash
   cd pop-os-postinstall
```
Define as permissões de execução

```bash
   chmod +x post_install.sh
```

Execute o arquivo principal com o parâmetro "initial" para realizar as configurações iniciais

```bash
  ./post_install.sh initial
```

Execute o arquivo principal com o parâmetro "install" para realizar a instalação dos pacotes .DEB, FLAT e SNAP

```bash
  ./post_install.sh install
```

Execute o arquivo principal com o parâmetro "config" para realizar a configuração dos Temas, do Terminal e do NVIM

```bash
  ./post_install.sh config
```
***

O Arquivo nvim_configs.md contém as intruções para instalação do OhMyZSH + Plugins no terminal.

Para alterar o tema 'Dracula' instalado, verificar a URL: "https://www.gnome-look.org/p/1687249". Buscar por "Dracula-shell-pink-accent-v40.tar.xz"

***

Após as configurações primárias, acessar o site: '''https://extensions.gnome.org/''' para realizar o download das extensões do Shell.

Instalar as extensões abaixo:
- [x] User Themes
- [x] Extension List
- [x] Removable Drive Menu
- [x] Clipboard Indicator
- [x] Sound Input & Output Device Chooser
- [x] Bluetooth Quick Connect
- [x] Control Blur Effect On Lock Screen

***

- [x] Definir atalhos para Spotify
- [x] Definir atalhos para bloquear tela
- [x] Definir atalho para Flameshot
- [x] Definir Montagem automática do outro HD

***
