# use vi keybindings by default
bindkey -v

# movement
# arrows/hjkl
bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history
bindkey '^[[C' forward-char
bindkey '^[[D' backward-char

bindkey '^b' backward-word # '^[[1;5D' ctrl-left
bindkey '^f' forward-word  # '^[[1;5C' ctrl-right

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

bindkey '^h' backward-delete-char
bindkey '^k' kill-line
bindkey '^[[3~' delete-char-or-list

# history
bindkey '^r' history-incremental-search-backward
bindkey '^t' history-beginning-search-backward
