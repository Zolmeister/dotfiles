ZSH=~/.oh-my-zsh
ZSH_THEME="zolmeister"

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
alias bower='noglob bower'
alias t='date "+%c"'
alias b='xrandr -q | grep " connected" | cut -d" " -f 1 | xargs -I display xrandr --output display --brightness'
alias att='atom .'

# editor
export EDITOR=vim

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

# Golang
GOROOT=~/Documents/go
GOPATH=~/.local

PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/include
PATH=$PATH:~/.local/bin # local
PATH=$PATH:$GOROOT/bin # go
PATH=$PATH:~/Documents/google-cloud-sdk/bin # Google cloud sdk
PATH=$PATH:~/Documents/android-studio/sdk/tools:~/Documents/android-studio/sdk/platform-tools # Android SDK

# Google Cloud SDK.
# https://github.com/GoogleCloudPlatform/gcloud/issues/32
#source ~/google-cloud-sdk/path.zsh.inc
PATH=$PATH:~/google-cloud-sdk/bin
source ~/google-cloud-sdk/completion.zsh.inc
