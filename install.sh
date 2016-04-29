#!/bin/bash

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
