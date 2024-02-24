autoload -U colors && colors

PS1=%{$fg[cyan]%}"%m %{$fg[yellow]%}%~ %{$fg[green]%}%# %{$reset_color%}"

if [[ $HOST = "jjuhasz--MacBookPro18" ]]
  then PS1=%{$fg[red]%}"work %{$fg[yellow]%}%~ %{$fg[green]%}%# %{$reset_color%}"
fi

if [[ $HOST = "jjuhaszQJHD2.vmware.com" ]]
  then PS1=%{$fg[red]%}"thirteen %{$fg[yellow]%}%~ %{$fg[green]%}%# %{$reset_color%}"
fi

PATH=$PATH:/opt/homebrew/bin:/usr/local/go/bin/:~/go/bin/


if -f /usr/bin/kubectl; then
    plugins=(
      kubectl
      go
    )
fi

autoload -Uz compinit
compinit

if -f /usr/bin/kubectl; then
    source <(kubectl completion zsh)
fi

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

set -o vi

alias ls='ls -F'
if -f /usr/bin/kubectl; then
    alias k='kubectl'
fi

alias gitget='cd ~/git/code; git fetch; git pull origin main; cd'
alias gitpush='cd ~/git/code; git add .; git commit; git push --set-upstream origin main; cd'

alias dotget='cd ~/git/dotrc; git fetch; git pull origin main; cd'
alias dotpush='cd ~/git/dotrc; git add .; git commit; git push --set-upstream origin main; cd'
alias dotclone='rm -rf ~/git/dotrc; cd ~/git; git clone https://github.com/jcnt/dotrc; cd'

