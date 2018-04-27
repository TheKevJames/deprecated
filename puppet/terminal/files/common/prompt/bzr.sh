function bzr_prompt() {
	STATUS_BRANCH=$(BZR_LOG=/dev/null bzr nick 2>/dev/null | grep -v "ERROR" | cut -d ":" -f2 | awk -F / '{print "bzr::"$1}')
	if [ -n "$STATUS_BRANCH" ]; then
		STATUS="$STYLE_BRANCH$STATUS_BRANCH$STYLE_END"
		if [[ -n $(BZR_LOG=/dev/null bzr status) ]]; then
			STATUS="$STATUS|$STYLE_UNTRACKED$STYLE_END"
		fi
        echo "(ⓑ $STATUS)"
	fi
}
