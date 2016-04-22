#!/usr/bin/env bash

set -e

if [[ "false" != "$TRAVIS_PULL_REQUEST" ]]; then
	echo "Not deploying pull requests."
	exit
fi

if [[ "master" != "$TRAVIS_BRANCH" ]]; then
	echo "Not on the 'master' branch."
	exit
fi

mkdir deploy
cd deploy
git clone https://${GH_REF} .
git checkout origin/gh-pages
cp ../README.md ./
rsync -az ../api/ api/
git commit --quiet -m "Deploy from travis"
git push --quiet "https://${GH_TOKEN}@${GH_REF}" origin gh-pages > /dev/null 2>&1
