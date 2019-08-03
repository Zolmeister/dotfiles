#!/bin/bash

echo "Checking for required packages"
# TODO: replace nitrogen with feh
hash nitrogen 2>/dev/null || {
  echo >&2 "nitrogen is required.  Aborting."
  exit 1
}
hash i3 2>/dev/null || {

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
# TODO: make sure file doesnt exist first
#mkdir -p ~/.i3
ln -s ~/zolmeister/dotfiles/i3/config ~/.config/i3/config

echo "restarting i3"
i3-msg restart

# font for powerline-shell
echo "installing patched ubuntu mono font for powerline-shell"
mkdir -p ~/.fonts
#git clone git@github.com:pdf/ubuntu-mono-powerline-ttf.git ~/.fonts/ubuntu-mono-powerline-ttf
git clone https://github.com/pdf/ubuntu-mono-powerline-ttf.git ~/.fonts/ubuntu-mono-powerline-ttf
fc-cache -vf

# install powerline-shell
# TODO: folder missing???
echo "installing powerline-shell"
# TODO: powerline-shell.py to specify python2
#git clone git@github.com:Zolmeister/powerline-shell.git ~/zolmeister/powerline-shell
git clone https://github.com/Zolmeister/powerline-shell.git ~/zolmeister/powerline-shell
cp ~/zolmeister/dotfiles/powerline-shell/config.py ~/zolmeister/powerline-shell/config.py
cp ~/zolmeister/dotfiles/powerline-shell/themes/zolmeister.py ~/zolmeister/powerline-shell/themes/zolmeister.py
cd ~/zolmeister/powerline-shell && ~/zolmeister/powerline-shell/install.py && cd -

# install oh-my-zsh
echo "installing oh-my-zsh"
#env git clone --depth=1 git@github.com:robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
env git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# zsh
echo "linking zsh theme"
ln -s ~/zolmeister/dotfiles/zolmeister.zsh-theme ~/.oh-my-zsh/themes/zolmeister.zsh-theme

echo "linking zsh config"
ln -s ~/zolmeister/dotfiles/.zshrc ~/.zshrc

# done
TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
    echo "setting default shell to zsh"
    chsh -s $(grep /zsh$ /etc/shells | tail -1)
fi
unset TEST_CURRENT_SHELL

echo "done"
#env zsh
#. ~/.zshrc
