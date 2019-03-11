#! /bin/sh -l
api_version=3
api_root='https://api.github.com'
commit_count=`curl -H "Authorization: token $GITHUB_TOKEN" "${api_root}/repos/j0nnyhughes/alpha/pulls/1/commits" | grep -o '"commit": {' | wc -l`
echo "commits: ${commit_count}"

if [ $commit_count -gt 4 ]
then 
    echo "INTERACTIVE REBASE YOU MUPPET"
else
    echo "LOOKS GOOD"
fi

echo $GITHUB_TOKEN
echo `token: ${GITHUB_TOKEN}`
