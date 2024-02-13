autoload -U colors && colors

PS1=%{$fg[blue]%}"%m %{$fg[yellow]%}%~ %{$fg[green]%}%# %{$reset_color%}"

if [[ $HOST = "jjuhasz--MacBookPro18" ]]
  then PS1=%{$fg[red]%}"work %{$fg[yellow]%}%~ %{$fg[green]%}%# %{$reset_color%}"
fi

if [[ $HOST = "jjuhaszQJHD2.vmware.com" ]]
  then PS1=%{$fg[red]%}"thirteen %{$fg[yellow]%}%~ %{$fg[green]%}%# %{$reset_color%}"
fi

PATH=$PATH:/opt/homebrew/bin:/usr/local/go/bin/
plugins=(
  kubectl
  go
)

autoload -Uz compinit
compinit
source <(kubectl completion zsh)

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

set -o vi

alias ls='ls -F'
alias k='kubectl'

alias gitget='cd ~/git/code; git fetch; git pull origin main; cd'
alias gitpush='cd ~/git/code; git add .; git commit; git push --set-upstream origin main; cd'

alias dotget='cd ~/git/dotrc; git fetch; git pull origin main; cd'
alias dotpush='cd ~/git/dotrc; git add .; git commit; git push --set-upstream origin main; cd'

