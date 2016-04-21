for sh in "$HOME"/.config/extras/*.sh; do
    [ -r "$sh" ] && . "$sh"
done
