#!/usr/bin/env sh

set -e

npm run build 

cd dist
git init
git add -A 
git commit -m"deployement"
git push -f git@github.com:Ankush123456-code/Covid-19_tracker.git
cd -