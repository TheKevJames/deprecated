set -a
[ -r /etc/environment ] && . /etc/environment
set +a

for sh in "$HOME"/.config/terminal/extras/*.sh; do
    [ -r "$sh" ] && . "$sh"
done
