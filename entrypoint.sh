#! /bin/sh

if [ -z "$GITHUB_TOKEN" ]
then
	echo "Set the GITHUB_TOKEN env variable."
	exit 1
fi

if [ !$GITHUB_EVENT_NAME = "PullRequestEvent" ]
then
	echo "Action only supports Pull Requests"
	exit 1
fi

commit_limit=${COMMIT_LIMIT:-5}
auth_header="Authorization: token ${GITHUB_TOKEN}"

event=$(cat $GITHUB_EVENT_PATH)
action=$(echo $event | jq -r '.action')
commit_count=$(echo $event | jq -r '.pull_request.commits')

echo "PR action: ${action}"
echo "PR contains ${commit_count} commit(s)"

if [ $commit_count -gt $commit_limit ]
then 
	COMMENT="Number of commits (${commit_count}) exceeds the limit of ${commit_limit}.  Please squash your commits."
	PAYLOAD=$(echo '{}' | jq --arg body "$COMMENT" '.body = $body')
	COMMENTS_URL=$(cat /github/workflow/event.json | jq -r .pull_request.comments_url)
	curl -s -S -H "Authorization: token $GITHUB_TOKEN" --header "Content-Type: application/json" --data "$PAYLOAD" "$COMMENTS_URL" > /dev/null
    exit 1
fi
