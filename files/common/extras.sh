for sh in "$HOME"/.config/terminal/extras/*.sh; do
    [ -r "$sh" ] && . "$sh"
done
