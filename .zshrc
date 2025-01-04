autoload -U colors && colors
autoload -Uz compinit && compinit

# NOW setup PS1 
#
NEWLINE=$'\n'
setopt prompt_subst

autoload -U add-zsh-hook
autoload -Uz vcs_info

add-zsh-hook precmd prompt_git_precmd

# git status based on https://github.com/JNRowe-retired-forks/oh-my-zsh/blob/master/themes/jnrowe.zsh-theme
prompt_git_precmd() {
    vcs_info

    if [ -z "${vcs_info_msg_0_}" ]; then
        git_dir_status=""
    elif ! git diff-index --cached --quiet --ignore-submodules HEAD 2>/dev/null; then
        git_dir_status="%F{red} %f"
    elif ! git diff --no-ext-diff --ignore-submodules --quiet 2>/dev/null; then
        git_dir_status="%F{red} %f"
    elif [[ `git status |grep -c ^Untracked` > 0 ]]; then
        git_dir_status="%F{red} %f"
    else
        git_dir_status="%F{green} %f"
    fi
}

PROMPT='${NEWLINE}%{%F{blue}%}%m %{%F{yellow}%}[%1~] ${git_dir_status}%B%(?.%F{green}.%F{red})%#%f %{$reset_color%}'

if [[ $HOST = "jjuhasz--MacBookPro18" ]]
    then PROMPT='${NEWLINE}%{%F{magenta}%}work %{%F{yellow}%}[%1~] ${git_dir_status}%B%(?.%F{green}.%F{red})%#%f %{$reset_color%}'
fi

if [[ $HOST = "jjuhaszQJHD2.vmware.com" ]]
    then PROMPT='${NEWLINE}%{%F{magenta}%}thirteen %{%F{yellow}%}[%1~] ${git_dir_status}%B%(?.%F{green}.%F{red})%#%f %{$reset_color%}'
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
        alias k3='cp ~/.kube/config.cluster3 ~/.kube/config'
        alias k4='cp ~/.kube/config.clusterbk ~/.kube/config'
fi

if [[ $HOST = "jjuhasz--MacBookPro18" ]]
    then
        alias prg='TERM=xterm-256color ssh ubu tmux attach'
fi

if [[ $HOST = "jjpxbkm" || $HOST = "jump" ]]
    then
        function lbstat() {echo "show stat" | sudo socat /run/haproxy/admin.sock stdio |awk -F',' {'printf ("%15s %15s %15s\n", $1, $2, $18)'};}
fi

if [[ $OSTYPE = "darwin23.0" ]]
    then
        PATH=$PATH:/opt/homebrew/bin:/usr/local/go/bin/:~/go/bin/
fi

if [[ -f /snap ]]; 
    then
        PATH=$PATH:/snap/bin
fi

if [[ -f /opt/homebrew/bin/nvim || -f /usr/bin/nvim ]]; 
    then
        alias vi="nvim"
        EDITOR=nvim
fi        

if [ -f /usr/bin/kubectl ]; 
    then
        plugins=(
            kubectl
            go
        )
fi

if [ -f /usr/bin/kubectl ]; 
    then
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

alias grep="grep --color"
alias p="python3"
alias bp="bpython"
alias gr="go run"
alias glpush='cd `git rev-parse --show-toplevel`;git add .; git commit -m "Lazy commit `date`"; git push; cd -'
alias glget='git fetch; git pull origin main;'
alias dotget='cd ~/git/dotrc; git fetch; git pull origin main; cd -'
alias dotpush='cd ~/git/dotrc; git add .; git commit -m "Lazy commit `date`"; git push; cd -'
alias dotclone='rm -rf ~/git/dotrc; git clone https://github.com/jcnt/dotrc ~/git/dotrc/'

px-deploy() { [ "$DEFAULTS" ] && params="-v $DEFAULTS:/px-deploy/.px-deploy/defaults.yml" ; docker run --network host -it -e PXDUSER=$USER --rm --name px-deploy.$$ $=params -v $HOME/.px-deploy:/px-deploy/.px-deploy px-deploy /root/go/bin/px-deploy $* ; }

