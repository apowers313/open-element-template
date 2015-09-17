#!/bin/bash

echo "Deploy Docs: Checking GitHub token..."
if [ -z "$GH_TOKEN" ]; then
	echo "GH_TOKEN not set, please visit https://github.com/settings/tokens to get a token and then set the environment variable"
	exit 1
fi

echo "Deploy Docs: Checking Travis repo..."
if [ -z "$TRAVIS_REPO_SLUG" ]; then
	TRAVIS_REPO_SLUG=`git config --get remote.origin.url | cut -d/ -f4-5 | cut -d. -f1`
fi

if [ -z "$TRAVIS_REPO_SLUG" ]; then
	TRAVIS_REPO_SLUG='{{github_slug}}'
fi

echo "Deploy Docs: Setting GitHub ref..."
GH_REF=github.com/$TRAVIS_REPO_SLUG.git
if [ -z "$GH_REF" ]; then
	echo "GH_REF is not set. Set it in the form \"github.com/<username>/<repo>.git\""
	exit 1
fi

# If this is the root repository, use the default docs
if [ "$INIT_DEFAULTS" == "1" ]; then
	echo "Deploy Docs: USING DEFAULT DOCUMENTS..."
	git checkout -f
fi

# inside this git repo we'll pretend to be a new user
echo "Deploy Docs: Doing git config..."
git config user.name "{{git_username}}"
git config user.email "{{git_email}}"

echo "Creating CHANGELOG.md ..."
if [ -z "$PKG_VERSION" ]; then
	PKG_VERSION=`cat package.json | grep version`
	echo "Version: " $PKG_VERSION
	node_modules/.bin/conventional-changelog -o CHANGELOG.md -p angular -r 0
	git add CHANGELOG.md
	git commit CHANGELOG.md -m "Automatically updating CHANGELOG.md via conventional-changelog"
	git push "https://${GH_TOKEN}@${GH_REF}" master
fi

echo "Deploy Docs: Building docs ..."
npm run docs

if [ -d coverage ]; then
	echo "Deploy Docs: Moving coverage ..."
	mv coverage docs
fi

echo "Deploy Docs: Uploading docs to: " $GH_REF ...

# go to the out directory and create a new git repo
cd docs
git init
git add .

# The first and only commit to this new Git repo contains all the
# files present with the commit message "Deploy docs to GitHub Pages".
echo "Deploy Docs: Doing git commit..."
git commit -m "Deploy docs to GitHub Pages"

# Force push from the current repo's master branch to the remote
# repo's gh-pages branch. (All previous history on the gh-pages branch
# will be lost, since we are overwriting it.) We redirect any output to
# /dev/null to hide any sensitive credential data that might otherwise be exposed.
echo "Deploy Docs: pushing docs to GitHub"
git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:gh-pages

echo "Deploy Docs: done."
