# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="zolmeister"
DEFAULT_USER=zoli

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
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
alias susp='i3lock -c 000000 -i ~/Pictures/Z/Z-bg.png && dbus-send --system --print-reply \
    --dest="org.freedesktop.UPower" \
    /org/freedesktop/UPower \
    org.freedesktop.UPower.Suspend'
alias t='date "+%c"'

export Websites=/home/zoli/workspace/websites
export Home=/mnt/hdd/home/zoli
export PYLEARN2_DATA_PATH=/data/lisa/data

# editor
export EDITOR="vim"

PATH=/home/zoli/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/include


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH:/home/zoli/Documents/adt-linux-64/sdk/platform-tools:/home/zoli/Documents/adt-linux-64/sdk/tools"

[[ -s /home/zoli/.nvm/nvm.sh ]] && . /home/zoli/.nvm/nvm.sh # This loads NVM

# powerline-shell
    function powerline_precmd() {
      export PS1="$(~/Documents/powerline-shell/powerline-shell.py $? --shell zsh 2> /dev/null)"
    }

    function install_powerline_precmd() {
      for s in "${precmd_functions[@]}"; do
        if [ "$s" = "powerline_precmd" ]; then
          return
        fi
      done
      precmd_functions+=(powerline_precmd)
    }

    install_powerline_precmd

# SSH keyring
export $(gnome-keyring-daemon --start --components=ssh 2>/dev/null)

# Golang
export GOPATH=$HOME/.local

# Google cloud sdk
export PATH="$PATH:/home/zoli/Documents/google-cloud-sdk/bin"

# Android SDK
export PATH="$PATH:/home/zoli/Documents/android-studio/sdk/tools:/home/zoli/Documents/android-studio/sdk/platform-tools"
