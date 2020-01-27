#!/bin/bash
[[ $(/usr/bin/git pull origin master) =~ "Already up to date." ]] && /app/deploy.sh