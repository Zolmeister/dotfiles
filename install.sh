#!/bin/bash

echo "Checking for required packages"
hash nitrogen 2>/dev/null || {
  echo >&2 "nitrogen is required.  Aborting."
  exit 1
}
hash i3 2>/dev/null || {
  echo >&2 "i3 is required.  Aborting."
  exit 1
}
hash git 2>/dev/null || {
  echo >&2 "git is required.  Aborting."
  exit 1
}
hash zsh 2>/dev/null || {
  echo >&2 "zsh is required.  Aborting."
  exit 1
}

# wallpaper
echo "setting wallpaper"
nitrogen --set-centered ~/zolmeister/dotfiles/Z-bg.png

# i3
echo "linking i3 config"
mkdir -p ~/.i3
ln -s ~/zolmeister/dotfiles/i3/config ~/.i3/config

echo "restarting i3"
i3-msg restart

# font for powerline-shell
echo "installing patched ubuntu mono font for powerline-shell"
mkdir -p ~/.fonts
git clone git@github.com:pdf/ubuntu-mono-powerline-ttf.git ~/.fonts/ubuntu-mono-powerline-ttf
fc-cache -vf

# install powerline-shell
echo "installing powerline-shell"
git clone git@github.com:Zolmeister/powerline-shell.git ~/zolmeister/powerline-shell
cp ~/zolmeister/dotfiles/powerline-shell/config.py ~/zolmeister/powerline-shell/config.py
cp ~/zolmeister/dotfiles/powerline-shell/themes/zolmeister.py ~/zolmeister/powerline-shell/themes/zolmeister.py
cd ~/zolmeister/powerline-shell && ~/zolmeister/powerline-shell/install.py && cd -

# install oh-my-zsh
echo "installing oh-my-zsh"
env git clone --depth=1 git@github.com:robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# zsh
echo "linking zsh theme"
ln -s ~/zolmeister/dotfiles/zolmeister.zsh-theme ~/.oh-my-zsh/themes/zolmeister.zsh-theme

echo "linking zsh config"
ln -s ~/zolmeister/dotfiles/.zshrc ~/.zshrc

# vim
echo "installing Vim journal mode"
ln -s ~/zolmeister/dotfiles/.vimrc ~/.vimrc

# done
TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
    echo "setting default shell to zsh"
    chsh -s $(grep /zsh$ /etc/shells | tail -1)
fi
unset TEST_CURRENT_SHELL

echo "done"
env zsh
. ~/.zshrc
