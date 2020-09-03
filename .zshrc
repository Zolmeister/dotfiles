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

# Keyboard navigation - only really fixes arrow keys, home and end overriden by gnome-terminal
# https://stackoverflow.com/questions/5407916/zsh-zle-shift-selection
r-delregion() {
  if ((REGION_ACTIVE)) then
     zle kill-region
  else
    local widget_name=$1
    shift
    zle $widget_name -- $@
  fi
}

r-deselect() {
  ((REGION_ACTIVE = 0))
  local widget_name=$1
  shift
  zle $widget_name -- $@
}

r-select() {
  ((REGION_ACTIVE)) || zle set-mark-command
  local widget_name=$1
  shift
  zle $widget_name -- $@
}

for key     kcap   seq        mode   widget (
    sleft   kLFT   $'\e[1;2D' select   backward-char
    sright  kRIT   $'\e[1;2C' select   forward-char
    sup     kri    $'\e[1;2A' select   up-line-or-history
    sdown   kind   $'\e[1;2B' select   down-line-or-history

    send    kEND   $'\e[1;2F' select   end-of-line
    send2   x      $'\e[4;2~' select   end-of-line

    shome   kHOME   $'\e[1;2H' select   beginning-of-line
    shome2  x      $'\e[1;2~' select   beginning-of-line

    left    kcub1  $'\eOD'    deselect backward-char
    right   kcuf1  $'\eOC'    deselect forward-char

    end     kend   $'\eOF'    deselect end-of-line
    end2    x      $'\e4~'    deselect end-of-line

    home    khome  $'\eOH'    deselect beginning-of-line
    home2   x      $'\e1~'    deselect beginning-of-line

    csleft  x      $'\e[1;6D' select   backward-word
    csright x      $'\e[1;6C' select   forward-word
    csend   x      $'\e[1;6F' select   end-of-line
    cshome  x      $'\e[1;6H' select   beginning-of-line

    cleft   x      $'\e[1;5D' deselect backward-word
    cright  x      $'\e[1;5C' deselect forward-word

    del     kdch1   $'\e[3~'  delregion delete-char
    bs      x       $'^?'     delregion backward-delete-char

  ) {
  eval "key-$key() {
    r-$mode $widget \$@
  }"
  zle -N key-$key
  bindkey ${terminfo[$kcap]-$seq} key-$key
}
