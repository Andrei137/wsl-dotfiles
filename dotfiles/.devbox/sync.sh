#!/usr/bin/env bash

ACTION=${1:-export}
REPO=$(jq -r '.repository' settings.json)

pushd src
if [[ ! -d .git ]]; then
    git init
    git remote add origin "$REPO"
fi
git branch --set-upstream-to=origin/main
if [[ "$ACTION" == "import" ]]; then
    git pull
    devbox global pull devbox.json
elif [[ "$ACTION" == "export" ]]; then
    devbox global push "$REPO"
    git pull
else
    echo "Invalid action. Use 'export' or 'import'"
    exit 1
fi
popd
