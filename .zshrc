autoload -U colors && colors
autoload -Uz compinit && compinit


# NOW setup PS1 
#
NEWLINE=$'\n'
setopt prompt_subst

autoload -U add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats \
    '%F{2}%s%F{7}:%F{2}(%F{1}%b%F{2})%f '
zstyle ':vcs_info:*' enable git hg

add-zsh-hook precmd prompt_jnrowe_precmd

# git status https://github.com/JNRowe-retired-forks/oh-my-zsh/blob/master/themes/jnrowe.zsh-theme
prompt_jnrowe_precmd() {
    vcs_info

    if [ -z "${vcs_info_msg_0_}" ]; then
        _jnrowe_dir_status=""
    elif ! git diff-index --cached --quiet --ignore-submodules HEAD 2>/dev/null; then
        _jnrowe_dir_status="%F{1} %f"
    elif ! git diff --no-ext-diff --ignore-submodules --quiet 2>/dev/null; then
        _jnrowe_dir_status="%F{3} %f"
    else
        _jnrowe_dir_status="%F{2} %f"
    fi
}

PROMPT='${NEWLINE}%{%F{cyan}%}%m %{%F{yellow}%}[%1~] ${_jnrowe_dir_status}%B%(?.%F{green}.%F{red})%#%f %{$reset_color%}'

if [[ $HOST = "jjuhasz--MacBookPro18" ]]
    then PROMPT='${NEWLINE}%{%F{red}%}work %{%F{yellow}%}[%1~] ${_jnrowe_dir_status}%B%(?.%F{green}.%F{red})%#%f %{$reset_color%}'
fi

if [[ $HOST = "jjuhaszQJHD2.vmware.com" ]]
    then PROMPT='${NEWLINE}%{%F{red}%}thirteen %{%F{yellow}%}[%1~] ${_jnrowe_dir_status}%B%(?.%F{green}.%F{red})%#%f %{$reset_color%}'
fi

if [[ -f ~/.zsh_zinit ]]
    then
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
            
        zinit cdreplay -q
        # bindkey '^f' autosuggest-accept
        bindkey '^p' history-search-backward
        bindkey '^n' history-search-forward
        
        zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
        
        # plugins
#        zinit snippet OMZP::git
#        zinit snippet OMZP::kubectl
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

set -o vi

# aliases
alias ls='ls -F --color'
if [ -f /usr/bin/kubectl ]; then
    alias k='kubectl'
fi

alias zsu='sudo su - -s /usr/bin/zsh'
if [[ $OSTYPE = "darwin23.0" ]]
    then
    alias zsu="sudo su -l root -c '/bin/zsh'"
fi

alias p="python3"
alias bp="bpython"
alias gr="go run"
alias glpush='git add .; git commit -m "Lazy commit `date`"; git push;'
alias glget='git fetch; git pull origin main;'
alias dotget='cd ~/git/dotrc; git fetch; git pull origin main; cd -'
alias dotpush='cd ~/git/dotrc; git add .; git commit -m "Lazy commit `date`"; git push; cd -'
alias dotclone='rm -rf ~/git/dotrc; git clone https://github.com/jcnt/dotrc ~/git/dotrc/'

px-deploy() { [ "$DEFAULTS" ] && params="-v $DEFAULTS:/px-deploy/.px-deploy/defaults.yml" ; docker run --network host -it -e PXDUSER=$USER --rm --name px-deploy.$$ $=params -v $HOME/.px-deploy:/px-deploy/.px-deploy px-deploy /root/go/bin/px-deploy $* ; }

