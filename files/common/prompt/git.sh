function updateVars() {
	unset CURRENT_STATUS

	GET_STATUS=$(python ~/.managed/term/prompt/git-status.py)
	if [ -n "$BASH_VERSION" ]; then
		IFS=', ' read -a CURRENT_STATUS <<< "$GET_STATUS"
		STATUS_BRANCH="${CURRENT_STATUS[0]}"
		STATUS_REMOTE="${CURRENT_STATUS[1]}"
		STATUS_STAGED="${CURRENT_STATUS[2]}"
		STATUS_CONFLICTS="${CURRENT_STATUS[3]}"
		STATUS_CHANGED="${CURRENT_STATUS[4]}"
		STATUS_UNTRACKED="${CURRENT_STATUS[5]}"
		STATUS_CLEAN="${CURRENT_STATUS[6]}"
	fi
	if [ -n "$ZSH_VERSION" ]; then
		CURRENT_STATUS=("${(@s/, /)GET_STATUS}")
		STATUS_BRANCH=$CURRENT_STATUS[1]
		STATUS_REMOTE=$CURRENT_STATUS[2]
		STATUS_STAGED=$CURRENT_STATUS[3]
		STATUS_CONFLICTS=$CURRENT_STATUS[4]
		STATUS_CHANGED=$CURRENT_STATUS[5]
		STATUS_UNTRACKED=$CURRENT_STATUS[6]
		STATUS_CLEAN=$CURRENT_STATUS[7]
	fi
}


git_prompt() {
	updateVars

	if [ -n "$CURRENT_STATUS" ]; then
		STATUS="$STYLE_BRANCH$STATUS_BRANCH$STYLE_END"
		if [ -n "$STATUS_REMOTE" ]; then
			STATUS="$STATUS$STYLE_REMOTE$STATUS_REMOTE$STYLE_END"
		fi

		CHANGES=""
		if [ "$STATUS_STAGED" -ne "0" ]; then
			CHANGES="$CHANGES$STYLE_STAGED$STATUS_STAGED$STYLE_END"
		fi
		if [ "$STATUS_CONFLICTS" -ne "0" ]; then
			CHANGES="$CHANGES$STYLE_CONFLICTS$STATUS_CONFLICTS$STYLE_END"
		fi
		if [ "$STATUS_CHANGED" -ne "0" ]; then
			CHANGES="$CHANGES$STYLE_CHANGED$STATUS_CHANGED$STYLE_END"
		fi
		if [ "$STATUS_UNTRACKED" -ne "0" ]; then
			CHANGES="$CHANGES$STYLE_UNTRACKED$STYLE_END"
		fi
		if [ "$STATUS_CLEAN" -eq "1" ]; then
			CHANGES="$CHANGES$STYLE_CLEAN$STYLE_END"
		fi

		echo "(ⓖ $STATUS|$CHANGES)"
	fi
}
