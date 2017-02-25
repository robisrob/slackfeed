#!/bin/bash

echo "New deploy\n"

au build --env prod

cd $HOME
git config --global push.default simple
git config --global user.email "travis@travis-ci.org"
git config --global user.name "travis-ci"
git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/robisrob/slackfeed gh-pages 2> /dev/null

mkdir -p gh-pages/app/scripts
cp $HOME/build/robisrob/slackfeed/index.html ./gh-pages/app/index.html
cp $HOME/build/robisrob/slackfeed/scripts/app-bundle.js ./gh-pages/app/scripts/app-bundle.js
cp $HOME/build/robisrob/slackfeed/scripts/vendor-bundle.js ./gh-pages/app/scripts/vendor-bundle.js

cd gh-pages
git add -A
git commit -m "new deploy: $TRAVIS_BUILD_NUMBER" 
git push --quiet 2> /dev/null
