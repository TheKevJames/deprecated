setopt always_to_end
setopt bash_autolist
unsetopt case_glob
setopt complete_aliases
setopt extended_glob
unsetopt menu_complete
setopt nomatch
setopt numeric_glob_sort

autoload -Uz compinit; compinit -d ~/.local/share/zsh/zcompdump; rm -f ~/.zcompdump
autoload -Uz promptinit; promptinit

zmodload zsh/complist

zstyle ':completion:*' menu select
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.local/share/zsh/zcompcache

zstyle ':completion:*' completer _expand _complete _expand_alias
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' remote-access false
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-perl true
zstyle ':completion:*' verbose true


setopt correct
SPROMPT='zsh: correct '%R' to '%r' ? ([Y]es/[N]o/[E]dit/[A]bort) '
