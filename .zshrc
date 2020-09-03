ZSH=~/.oh-my-zsh
ZSH_THEME="zolmeister"

XDG_CURRENT_DESKTOP=GNOME
GTK_THEME=Adwaita:dark
GDK_SCALE=1.5
GDK_DPI_SCALE=0.75
QT_AUTO_SCREEN_SCALE_FACTOR=1

CASE_SENSITIVE="true"

DISABLE_AUTO_UPDATE="true"

# (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git z)

source $ZSH/oh-my-zsh.sh
unsetopt correct_all

# History
SAVEHIST=100000000
unsetopt hist_expire_dups_first
unsetopt hist_ignore_dups
unsetopt inc_append_history
unsetopt share_history

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias t='date "+%c"'
alias b='xrandr -q | grep " connected" | cut -d" " -f 1 | xargs -I display xrandr --output display --brightness'
alias att='atom --force-device-scale-factor=1.5 .'
alias monitor-audio-on='pacmd load-module module-loopback latency_msec=16 source=3 sink=1 channels=2 channel_map=mono,mono'
alias monitor-audio-off='pacmd unload-module module-loopback'

# editor
EDITOR=vim

# powerline-shell
function powerline_precmd() {
  PS1="$(~/zolmeister/powerline-shell/powerline-shell.py $? --shell zsh 2> /dev/null)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi

# SSH keyring
export $(gnome-keyring-daemon --start --components=ssh 2>/dev/null)

# .local
PATH=$PATH:~/.local/bin

# Cargo
PATH=$PATH:~/.cargo/bin
