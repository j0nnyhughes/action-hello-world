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
    echo "Number of commits exceeds the limit of ${commit_limit}, please perform an interactive rebase"
    exit 1
fi