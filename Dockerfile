FROM debian:9.5-slim

LABEL "com.github.actions.name"="PR Commit Limit"
LABEL "com.github.actions.description"="Checks commit count on a PR and fails the check if it's over the limit"
LABEL "com.github.actions.icon"="git-commit"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/j0nnyhughes/action-pr-commit-limit"
LABEL "homepage"="https://github.com/j0nnyhughes/action-pr-commit-limit"
LABEL "maintainer"="Jonny Hughes"

RUN apt-get update
RUN apt-get -y install curl jq

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]