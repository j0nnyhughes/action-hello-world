#! /bin/sh
api_version=3
api_root='https://api.github.com'

if [ -z "$GITHUB_TOKEN" ]
then
	echo "Set the GITHUB_TOKEN env variable."
	exit 1
fi

AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

commit_count=$(curl -s -H "${AUTH_HEADER}" "${api_root}/repos/j0nnyhughes/alpha/pulls/1/commits" | grep -o '"commit": {' | wc -l)
echo "commits: ${commit_count}"

if [ $commit_count -gt 4 ]
then 
    echo "INTERACTIVE REBASE YOU MUPPET"
else
    echo "LOOKS GOOD"
fi