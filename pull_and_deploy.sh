#!/bin/bash
[[ $(/usr/bin/git pull origin master) =~ "Already up to date." ]] && /deploy/deploy.sh