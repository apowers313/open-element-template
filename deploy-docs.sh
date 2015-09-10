#!/bin/bash
# https://github.com/settings/tokens

if [ -z "$GH_TOKEN" ]; then
	echo "GH_TOKEN not set, please visit https://github.com/settings/tokens to get a token and then set the environment variable"
	exit 1
fi

if [ -z "$TRAVIS_REPO_SLUG" ]; then
	TRAVIS_REPO_SLUG=`git config --get remote.origin.url | cut -d/ -f4-5 | cut -d. -f1`
fi

if [ -z "$TRAVIS_REPO_SLUG" ]; then
	TRAVIS_REPO_SLUG='{{github_slug}}'
fi

GH_REF=github.com/$TRAVIS_REPO_SLUG.git
if [ -z "$GH_REF" ]; then
	echo "GH_REF is not set. Set it in the form \"github.com/<username>/<repo>.git\""
	exit 1
fi

echo "Building docs ..."
npm run docs

if [ -d coverage ]; then
	echo "Moving coverage ..."
	mv coverage docs
fi

echo "Uploading docs to: " $GH_REF ...

# go to the out directory and create a new git repo
cd docs
git init

# inside this git repo we'll pretend to be a new user
git config user.name "{{git_username}}"
git config user.email "{{git_email}}"
git add .

# The first and only commit to this new Git repo contains all the
# files present with the commit message "Deploy docs to GitHub Pages".
git commit -m "Deploy docs to GitHub Pages"

# Force push from the current repo's master branch to the remote
# repo's gh-pages branch. (All previous history on the gh-pages branch
# will be lost, since we are overwriting it.) We redirect any output to
# /dev/null to hide any sensitive credential data that might otherwise be exposed.
git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:gh-pages

# http(s)://<username>.github.io/<projectname>