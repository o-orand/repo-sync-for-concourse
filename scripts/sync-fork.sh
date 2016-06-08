#!/usr/bin/env bash


set -e
OUTPUT="$PWD/target-sync"

echo "DEBUG - OUTPUT: <$OUTPUT>"

git config --global user.name "$GH_USER"
git config --global user.email "$GH_USER_EMAIL"

FINAL_RELEASE_REPO=target-sync

git clone target ${FINAL_RELEASE_REPO}

pushd upstream
    echo "Process upstream"
    git fetch --all -q
    export UPSTREAM_URL=$(git ls-remote --get-url origin)
popd

pushd target
    echo "Process target"
    git fetch --all -q
    export TARGET_URL=$(git ls-remote --get-url origin)
popd


pushd ${FINAL_RELEASE_REPO}/
    echo "Process ${FINAL_RELEASE_REPO}"

    git remote add upstream ../upstream
    remote=upstream ; for brname in `git branch -r | grep upstream | grep -v master | grep -v HEAD | sed -e 's/.*\///g'`; do git branch --track $brname  $remote/$brname ; done

    git remote rename origin origin-local
    git remote add origin $TARGET_URL
popd





