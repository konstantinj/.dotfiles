#!/bin/zsh

if [ ! -d ~/.oh-my-zsh ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-completions ]; then
	git clone https://github.com/zsh-users/zsh-completions.git ~/.oh-my-zsh/custom/plugins/zsh-completions
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

if [ ! -d ~/.oh-my-zsh/custom/themes/powerlevel9k ]; then
	git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
fi

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

time=$(date +%s)
files=( ".vimrc" ".zshrc" )

for file in "${files[@]}"; do
  cur_file=$HOME/$file
  new_file=$(realpath $file)
  if [ -f $cur_file ]; then
    mv $cur_file $cur_file.$time.bak
  fi
  if [ -L $cur_file ]; then
    rm -f $cur_file
  fi
  ln -sn $new_file $cur_file
done

vim +PluginInstall +qall
