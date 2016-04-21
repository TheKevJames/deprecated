__rprompt() {
    printf "%*s\r" "$COLUMNS" "$(eval echo "$RPROMPT")"
}

function username {
    name=$(whoami)
    if [[ $name == "root" ]]; then
        echo "${fg_cyan_bold}\u"
    else
        echo "${fg_cyan}\u"
    fi
}

PROMPT_COMMAND='BZR=$(bzr_prompt);GIT=$(git_prompt);SVN=$(svn_prompt);__rprompt;PS1="${fg_lgray}[$(username)${fg_cyan}@\h${fg_purple}(bash)${fg_lgray}:${fg_cyan}\w${fg_lgray}]${fg_default}$BZR$GIT$SVN "'
