#!/usr/bin/env bash


set -e
echo "DEBUG - OUTPUT: <$OUTPUT>"

git config --global user.name "$GH_USER"
git config --global user.email "$GH_USER_EMAIL"

pushd target-sync
    git push --all origin
    git push --tags origin
popd





