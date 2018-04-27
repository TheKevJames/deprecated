svn_prompt() {
	if [ $(svn info >/dev/null 2>&1 | wc -l) -gt 1 ]; then
		URL=$(svn info | awk '/URL:/ {print $2}')
		CURRENT_STATUS=$(svn status)
		MODIFIED_COUNT=$(echo "$CURRENT_STATUS" | grep "^M\|^R\|^D\|^~\|^!" | wc -l | tr -d ' ')
		CONFLICTS_COUNT=$(echo "$CURRENT_STATUS" | grep "^C" | wc -l | tr -d ' ')
		ADDED_COUNT=$(echo "$CURRENT_STATUS" | grep "^A" | wc -l | tr -d ' ')
		UNTRACKED_COUNT=$(echo "$CURRENT_STATUS" | grep "^?" | wc -l | tr -d ' ')

		if [[ $URL =~ trunk ]]; then
			STATUS="trunk"
			STATUS="$STYLE_TRUNK$STATUS"
		elif [[ $URL =~ /branches/ ]]; then
			STATUS=$(echo "$URL" | sed 's/.*branches\///')
			STATUS="$STYLE_BRANCH$STATUS"
		elif [[ $URL =~ /tags/ ]]; then
			STATUS=$(echo "$URL" | sed 's/.*tags\///')
			STATUS="$STYLE_TAG$STATUS"
		fi
		STATUS="$STATUS$STYLE_END"

		CHANGES=""
		if [ "$MODIFIED_COUNT" -ne "0" ]; then
			CHANGES="$CHANGES$STYLE_STAGED$MODIFIED_COUNT$STYLE_END"
		fi
		if [ "$CONFLICTS_COUNT" -ne "0" ]; then
			CHANGES="$CHANGES$STYLE_CONFLICTS$CONFLICTS_COUNT$STYLE_END"
		fi
		if [ "$ADDED_COUNT" -ne "0" ]; then
			CHANGES="$CHANGES$STYLE_CHANGED$ADDED_COUNT$STYLE_END"
		fi
		if [ "$UNTRACKED_COUNT" -ne "0" ]; then
			CHANGES="$CHANGES$STYLE_UNTRACKED$STYLE_END"
		fi
		if [ -z $CHANGES ]; then
			CHANGES="$STYLE_CLEAN$STYLE_END"
		fi

		echo "(ⓢ $STATUS|$CHANGES)"
	fi
}
