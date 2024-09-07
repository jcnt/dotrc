autoload -U colors && colors

PS1=%{$fg[cyan]%}"%m %{$fg[yellow]%}[%1~] %{$fg_bold[green]%}%# %{$reset_color%}"
alias zsu='sudo su - -s /usr/bin/zsh'

if [[ $HOST = "jjuhasz--MacBookPro18" ]]
  then PS1=%{$fg[red]%}"work %{$fg[yellow]%}[%1~] %{$fg_bold[green]%}%# %{$reset_color%}"
  alias zsu="sudo su -l root -c '/bin/zsh'"
fi

if [[ $HOST = "jjuhaszQJHD2.vmware.com" ]]
  then PS1=%{$fg[red]%}"thirteen %{$fg[yellow]%}[%1~] %{$fg_bold[green]%}%# %{$reset_color%}"
  alias zsu="sudo su -l root -c '/bin/zsh'"
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

autoload -Uz compinit
compinit

if [ -f /usr/bin/kubectl ]; then
    source <(kubectl completion zsh)
fi

# Keep 10000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

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
alias dotclone='rm -rf ~/git/dotrc; cd ~/git; git clone https://github.com/jcnt/dotrc; cd -'

