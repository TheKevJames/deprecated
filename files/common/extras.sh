for sh in "$HOME"/.managed/extras/*.sh; do
    [ -r "$sh" ] && . "$sh"
done
