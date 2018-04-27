setopt PROMPT_SUBST

function boldIfRoot {
	if [[ $(whoami) == "root" ]]; then
		echo "${at_bold}"
	fi
}

PROMPT='%{$fg_lgray%}[%{$fg_cyan%}$(boldIfRoot)%n%{$at_boldoff%}@%m%{$fg_purple%}(zsh)%{$fg_lgray%}:%{$fg_cyan%}%~%{$fg_lgray%}]%{$at_normal%}$(bzr_prompt)$(git_prompt)$(svn_prompt) '
RPROMPT=''
