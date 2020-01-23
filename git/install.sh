#!/bin/bash

if [[ ! -z $GITHUB_TOKEN ]]; then
    read -p "Paste your GitHub Personal Access Token here: " token
    export GITHUB_TOKEN=$token
fi

local CFG=`cat template.gitconfig | sed "s|%GITHUBTOKEN%|${GITHUB_TOKEN}|g"`
echo $CFG > ~/.gitconfig
