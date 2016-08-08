# Konstantins .dotfiles

## Installation

- install zsh
- sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
- git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
- curl -sL https://download.getcarina.com/dvm/latest/install.sh | sh
- git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
- git clone https://github.com/konstantinj/.dotfiles.git
- cd .dotfiles && ./install.sh

## What's included?

Currently I've only included my .zshrc and my .vimrc.
When running install.sh your current files will be backed up and links to the files in this repo will be created.

### .zshrc

Of yource I'm using [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) so you need to install it.

I'm using the powerlevel9k theme and have added custom sections for docker and aws.
I'm working quite heavily with docker, aws and php. Therefore my .zshrc is optimized for that.

The docker section shows the currently used docker client/server-version and -ip. The aws section shows the currently used profile.

Of course you need to load both first. I'm using ```ldm``` e.g. to connect to my docker-machine.
Since I'm working with different docker servers I need the docker version manager.
You need to install [docker version manager](https://github.com/getcarina/dvm) 

### .vimrc

There is too much stuff in the .vimrc. Just take a look what I do.
But you need to install [vundle](https://github.com/VundleVim/Vundle.vim) before you can use it.

## What else?

I'm mainly using osx. Some things are optimized for that but I'm also using the same config on linux.
