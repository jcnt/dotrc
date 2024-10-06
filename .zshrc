autoload -U colors && colors

# set home for zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# download zinit if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi 

source "${ZINIT_HOME}/zinit.zsh"

# zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

autoload -Uz compinit && compinit

zinit cdreplay -q


# NOW setup PS1 
#
NEWLINE=$'\n'

PS1=${NEWLINE}%{%F{cyan}%}"%m %{%F{yellow}%}[%1~] %B%(?.%F{green}.%F{red})%#%f %{$reset_color%}"
alias zsu='sudo su - -s /usr/bin/zsh'

if [[ $HOST = "jjuhasz--MacBookPro18" ]]
  then PS1=${NEWLINE}%{%F{red}%}"work %{%F{yellow}%}[%1~] %B%(?.%F{green}.%F{red})%#%f %{$reset_color%}"
  alias zsu="sudo su -l root -c '/bin/zsh'"
fi

if [[ $HOST = "jjuhaszQJHD2.vmware.com" ]]
  then PS1=${NEWLINE}%{%F{red}%}"thirteen %{%F{yellow}%}[%1~] %B%(?.%F{green}.%F{red})%#%f %{$reset_color%}"
  alias zsu="sudo su -l root -c '/bin/zsh'"
fi

if [[ $HOST = "jjuhasz--MacBookPro18" || $HOST = "jjuhaszQJHD2.vmware.com" || $HOST = "jump" || $HOST = "jjrhel"]]
    TESTENV="hello"
fi

if [[ $HOST = "jump" ]]
    then
        alias k1='cp ~/.kube/config.cluster1 ~/.kube/config'
        alias k2='cp ~/.kube/config.cluster2 ~/.kube/config'
fi

if [[ $OSTYPE = "darwin23.0" ]]
    then
        PATH=$PATH:/opt/homebrew/bin:/usr/local/go/bin/:~/go/bin/
fi

if [[ -f /opt/homebrew/bin/nvim || -f /usr/bin/nvim ]]; then
    alias vi="nvim"
fi        

if [ -f /usr/bin/kubectl ]; then
    plugins=(
      kubectl
      go
    )
fi


if [ -f /usr/bin/kubectl ]; then
    source <(kubectl completion zsh)
fi

# Keep 10000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# bindkey '^f' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# plugins
zinit snippet OMZP::git
zinit snippet OMZP::kubectl

set -o vi

alias ls='ls -F --color'
if [ -f /usr/bin/kubectl ]; then
    alias k='kubectl'
fi

alias p="python3"
alias codeget='cd ~/git/code; git fetch; git pull origin main; cd -'
alias codepush='cd ~/git/code; git add .; git commit -m "Lazy commit `date`"; git push; cd -'
alias dotget='cd ~/git/dotrc; git fetch; git pull origin main; cd -'
alias dotpush='cd ~/git/dotrc; git add .; git commit -m "Lazy commit `date`"; git push; cd -'
alias dotclone='rm -rf ~/git/dotrc; git clone https://github.com/jcnt/dotrc ~/git/dotrc/'

px-deploy() { [ "$DEFAULTS" ] && params="-v $DEFAULTS:/px-deploy/.px-deploy/defaults.yml" ; docker run --network host -it -e PXDUSER=$USER --rm --name px-deploy.$$ $=params -v $HOME/.px-deploy:/px-deploy/.px-deploy px-deploy /root/go/bin/px-deploy $* ; }
