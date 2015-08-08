ZSH=~/.oh-my-zsh
ZSH_THEME="zolmeister"

CASE_SENSITIVE="true"

DISABLE_AUTO_UPDATE="true"

# (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh
unsetopt correct_all

# History
SAVEHIST=100000000
unsetopt hist_expire_dups_first
unsetopt hist_ignore_dups
unsetopt inc_append_history
unsetopt share_history

encode64(){ echo -n $1 | base64 }
decode64(){ echo -n $1 | base64 -D }
alias e64=encode64
alias d64=decode64

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias bower='noglob bower'
alias pm-suspend='/usr/sbin/pm-suspend'
alias susp='i3lock -c 000000 -i ~/zolmeister/dotfiles/Z-bg.png && dbus-send --system --print-reply \
    --dest="org.freedesktop.UPower" \
    /org/freedesktop/UPower \
    org.freedesktop.UPower.Suspend'
alias t='date "+%c"'
alias b='xrandr -q | grep " connected" | cut -d" " -f 1 | xargs -I display xrandr --output display --brightness'

export Websites=~/workspace/websites
export Home=/mnt/hdd~
export PYLEARN2_DATA_PATH=/data/lisa/data

# editor
export EDITOR="vim"

PATH=~/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/include


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH:~/Documents/adt-linux-64/sdk/platform-tools:~/Documents/adt-linux-64/sdk/tools"

[[ -s ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh # This loads NVM

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

# host aliases
export HOSTALIASES=~/.hosts

# Golang
export GOROOT="~/Documents/go"
export PATH="$PATH:$GOROOT/bin"
export GOPATH=~/.local

# Google cloud sdk
export PATH="$PATH:~/Documents/google-cloud-sdk/bin"

# Android SDK
export PATH="$PATH:~/Documents/android-studio/sdk/tools:~/Documents/android-studio/sdk/platform-tools"

# The next line updates PATH for the Google Cloud SDK.
#source '~/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
#source '~/google-cloud-sdk/completion.zsh.inc'
