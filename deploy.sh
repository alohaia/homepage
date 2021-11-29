#!/bin/bash

if [[ $# -gt 0 ]]; then
    mes="`date date +%Y-%m-%dT%T%:z` $1"
else
    mes="`date date +%Y-%m-%dT%T%:z`"
fi

git add .
git commit -m "${mes}"
git push
