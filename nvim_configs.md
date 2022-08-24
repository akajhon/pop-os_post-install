Caso seja necessário, antes dos procedimentos abaixo, instale o ZSH: 

```bash
   sudo apt-get install zsh 
```

Installing NVM
 
 ```bash
   sh -c "$(curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh)"
```

Installing OhMyZSH

 ```bash
   sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

 ```bash
   chsh -s /bin/zsh
```

Fechar o Terminal e Reiniciar a máquina
Já estando com o ZSH configurado, executar os comandos abaixo:

Installing ZINIT
 
  ```bash
   sh -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
```

 ```bash
   zinit self-update
```

Installing Spaceship theme
 
 ```bash
   git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
```

 ```bash
   ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```

Configs -  Utilizar o arquivo ".zshrc" presente no repósitório.
 
  ```bash
   sudo mv zshrc .zshrc
```

 ```bash
   sudo mv -f .zshrc "/home/$USERNAME/"
```

Caso toda vez que abrir o terminal apareça uma falha no ZINIT, verificar as linhas escritas pelo ZINIT no .'zshrc"

Verificar se o nome do usuário esta correto na linha abaixo: 

 ```bash
   export ZSH="/home/akajhon/.oh-my-zsh" 
```

Links:

 ```bash
   https://blog.rocketseat.com.br/terminal-com-oh-my-zsh-spaceship-dracula-e-mais/
   https://blog.cod3r.com.br/terminal-customizado-windows-linux-e-macos/
```
