# alias
alias ls='ls -hG'
alias cleanosx="sudo find / -type f -name '*.DS_Store' -ls -delete; sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# convenience commands
dureadable() {
    if [ -z "$1" ]; then
        duresults=$(du -d1 -k .)
    else
        duresults=$(du -d1 -k "$1")
    fi

    echo "$duresults" | sort -nr | awk '{ if($1>=1024*1024) {size=$1/1024/1024; unit="G"} else if($1>=1024) {size=$1/1024; unit="M"} else {size=$1; unit="K"}; if(size<10) format="%.1f%s"; else format="%.0f%s"; res=sprintf(format,size,unit); printf "%-8s %s\n",res,$2 $3 $4 $5 $6 $7 $8 $9}'
}

frameworkpython() {
    if [[ ! -z "$VIRTUAL_ENV" ]]; then
        PYTHONHOME=$VIRTUAL_ENV /usr/local/bin/python "$@"
    else
        /usr/local/bin/python "$@"
    fi
}

# missing commands
command -v md5sum > /dev/null || alias md5sum="md5"
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Fix compilations
export ARCHFLAGS="-arch x86_64"

# Because this will often work better than setting a real value
export BROWSER='open'

# X11
export DISPLAY=:0
export PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig

# reasonable defaults
# key repeat > key hold
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 0
# use list view in finder
defaults write com.apple.Finder FXPreferredViewStyle Nlsv
# do not create .DS_Store files on network drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
# show ~/Library
chflags nohidden ~/Library
# show removables on desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

ulimit -n 2048
ulimit -u 512
