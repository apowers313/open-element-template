#!/bin/bash
echo Using shell: $SHELL
${SHELL} --version

DRY_RUN=1
# defaults to dry run unless "justdoit" is passed in
if [ "$1" == "justdoit" ]; then
	DRY_RUN=0
fi

function open_browser
{
	if [ "$browser" == "y" ]; then
		sleep $1
		open $2 &
		echo ""
	else
		echo "Please open your browser to:"
		echo "$2"
		echo ""
	fi
}

function run_cmd
{
	if [ $DRY_RUN -eq 1 ]; then
		echo DRY RUN: \"$@\"
	else
		echo "Running: \"$@\""
		$@
	fi
}

function do_config
{
	echo "Installing some tools ..."
	sleep 2

	npm install handlebars-cmd
	npm install strip-ansi-cli
	npm install json
	export CXX="/usr/bin/g++ -I/opt/local/include" # fixes path bug for OSX using macports
	npm install travis-encrypt

	rm -rf .configcache
	mkdir -p .configcache
	mkdir -p .configcache/demo
	mkdir -p .configcache/test

	echo "{" > .configcache/data.json
	echo "\"project_name\": \"$project_name\"," >> .configcache/data.json
	echo "\"element_name\": \"$element_name\"," >> .configcache/data.json
	echo "\"element_desc\": \"$element_desc\"," >> .configcache/data.json
	echo "\"github_repo_url\": \"$github_repo_url\"," >> .configcache/data.json
	echo "\"github_account\": \"$github_account\"," >> .configcache/data.json
	echo "\"github_repo\": \"$github_repo\"," >> .configcache/data.json
	echo "\"github_slug\": \"$github_slug\"," >> .configcache/data.json
	echo "\"git_username\": \"$git_username\"," >> .configcache/data.json
	echo "\"git_email\": \"$git_email\"," >> .configcache/data.json
	# ugh... stupid Polymer data bindings get in the way... need a better tool than handlebars-cmd
	echo "\"testProperty\": \"{{testProperty}}\"" >> .configcache/data.json
	echo "}" >> .configcache/data.json

	#####
	# Update files
	#####
	files="open-element.html yuidoc.json deploy-docs.sh test/index.html test/open-element.html demo/index.html wct.conf.js"
	for file in $files; do
		echo "Updating $file ..."
		# this seems silly, but it allows dry run to save the files in a parallel file structure if run_cmd does nothing
		./node_modules/.bin/handlebars .configcache/data.json < $file >	.configcache/$file
		run_cmd "mv .configcache/$file $file"
	done
	rm -rf .configcache/demo
	rm -rf .configcache/test

	#####
	# Update package info
	#####
	echo "Updating package.json ..."
	cat package.json | ./node_modules/.bin/json \
	    -e "this.name = '$element_name'" \
	    -e "this.version = '0.0.1'" \
	    -e "this.description = '$element_desc'" \
	    -e "this.main = '$element_name.html'" \
	    -e "this.scripts.demo = 'bash -c \\'sleep 1 && open http://localhost:8000/components/$element_name/demo/index.html &\\' && ./node_modules/.bin/polyserve -p 8000'" \
	    -e "this.repository.url = '$github_repo_url'" \
	    -e "this.author = '$git_email'" \
	    -e "this.bugs.url = '$github_repo_url'" \
	    -e "this.homepage = '$github_repo_url#readme'" > .configcache/package.json

	echo "Updating bower.json ..."
	cat bower.json | ./node_modules/.bin/json \
	    -e "this.name = '$element_name'" \
	    -e "this.version = '0.0.1'" \
	    -e "this.authors[0] = '$git_username <$git_email>'" \
	    -e "this.description = '$element_desc'" \
	    -e "this.main = '$element_name.html'" .configcache/bower.json

	#####
	# Update License
	#####
	echo "Upodating LICENSE ..."
	cat LICENSE | sed "s/Adam Powers/$git_username/g" > .configcache/LICENSE

	#####
	# Update Travis YML
	#####
	echo "Upodating Travis CI config (.travis.yml) ..."
	cat .travis.yml | grep -v secure: > .configcache/.travis.yml
	{ echo -n "    - secure: "; ./node_modules/.bin/travis-encrypt -r $github_slug SAUCE_ACCESS_KEY=$saucelabs_account_key | sed -n 2p | ./node_modules/.bin/strip-ansi; } >> .configcache/.travis.yml
	{ echo -n "    - secure: "; ./node_modules/.bin/travis-encrypt -r $github_slug SAUCE_USERNAME=$github_account | sed -n 2p | ./node_modules/.bin/strip-ansi; } >> .configcache/.travis.yml
	{ echo -n "    - secure: "; ./node_modules/.bin/travis-encrypt -r $github_slug GH_TOKEN=$github_token | sed -n 2p | ./node_modules/.bin/strip-ansi; } >> .configcache/.travis.yml
	{ echo -n "    - secure: "; ./node_modules/.bin/travis-encrypt -r $github_slug NPM_TOKEN=$npm_token | sed -n 2p | ./node_modules/.bin/strip-ansi; } >> .configcache/.travis.yml

	#####
	# Create README.md with badges
	#####
	echo "Updating README.md ..."
	echo "# $project_name" > .configcache/README.md
	echo "" >> .configcache/README.md
	echo "<table><tr><td>Community</td>" >> .configcache/README.md
	echo "<td>$gitter_badge</td>" >> .configcache/README.md
	echo "<td>$forkability_badge</td>" >> .configcache/README.md
	echo "<td>$license_badge</td>" >> .configcache/README.md
	echo "</tr><tr><td>Package</td>" >> .configcache/README.md
	echo "<td>$npm_badge</td>" >> .configcache/README.md
	echo "<td>$bower_badge</td> " >> .configcache/README.md
	echo "<td>$downloads_badge</td>" >> .configcache/README.md
	echo "</tr><tr><td>Dependencies</td>" >> .configcache/README.md
	echo "<td>$david_dep_badge</td>" >> .configcache/README.md
	echo "<td>$david_devdep_badge</td>" >> .configcache/README.md
	echo "<td></td>" >> .configcache/README.md
	echo "</tr><tr><td>Build</td>" >> .configcache/README.md
	echo "<td>$travis_badge</td>" >> .configcache/README.md
	echo "<td>$saucelabs_small_badge</td>" >> .configcache/README.md
	echo "<td>$coveralls_badge</td>" >> .configcache/README.md
	echo "</tr><tr><td>Release</td>" >> .configcache/README.md
	echo "<td>$commitizen_badge</td>" >> .configcache/README.md
	echo "<td>$semantic_release_badge</td>" >> .configcache/README.md
	echo "<td></td></tr></table>" >> .configcache/README.md
	echo "" >> .configcache/README.md
	echo $saucelabs_big_badge >> .configcache/README.md
	echo "" >> .configcache/README.md
	echo "$element_desc" >> .configcache/README.md
	echo "" >> .configcache/README.md
	echo "[Documentation](http://$github_account.github.io/$github_repo/)" >> .configcache/README.md
	echo "" >> .configcache/README.md
	echo "[Istanbul Coverage Report](http://$github_account.github.io/$github_repo/coverage/)" >> .configcache/README.md

	#####
	# Rename files
	#####
	echo "Shuffling files ..."
	run_cmd "git mv open-element.html $element_name.html"
	run_cmd "git mv test/open-element.html test/$element_name.html"
	run_cmd "rm .configcache/data.json"
	run_cmd "mv .configcache/* ."
	run_cmd "rm -rf .configcache" 

	#####
	# Set Environment Variables?
	#####
	echo "Saving environment ..."
	echo ""
	echo "This script has created some environment variables" 
	echo "that you will need for testing and creating releases."
	# Removing so that this information doesn't end up in Travis CI logs
	# echo "SAUCE_USERNAME=$github_account"
	# echo "SAUCE_ACCESS_KEY=$saucelabs_account_key"
	# echo "GH_TOKEN=$github_token"
	# echo "NPM_TOKEN=$npm_token"
	echo ""
	echo "They have been saved to .build.env, which will be ignored"
	echo "by git."
	echo ""
	echo "IF YOU DELETE THIS DIRECTORY THEY WILL BE GONE FOREVER"
	echo ""

	run_cmd "echo # $project_name config variables > .build.env"
	run_cmd "echo export SAUCE_USERNAME=$github_account >> .build.env"
	run_cmd "echo export SAUCE_ACCESS_KEY=$saucelabs_account_key >> .build.env"
	run_cmd "echo export GH_TOKEN=$github_token >> .build.env"
	run_cmd "echo export NPM_TOKEN=$npm_token >> .build.env"

	#####
	# Set new master repo
	#####
	run_cmd "git remote set-url origin $github_repo_url"

	#####
	# Clean up
	#####
	echo "Self destructing... thank you and good-bye!"
	run_cmd "rm config.sh"

	npm uninstall handlebars-cmd
	npm uninstall strip-ansi-cli
	npm uninstall json
	npm uninstall travis-encrypt
}

if [ "$INIT_DEFAULTS" == "1" ]; then
	echo "Detected home repo, running config.sh with default options ..."
	project_name="Open Element"
	element_name="open-element-template"
	element_desc="A template for new open source Polymer elements"
	github_repo_url='https://github.com/apowers313/open-element-template'
	github_account='apowers313'
	github_repo='open-element-template'
	github_slug='apowers313/open-element-template'
	git_username='Adam Powers'
	git_email='apowers@ato.ms'
	saucelabs_account_key=$SAUCE_ACCESS_KEY
	github_token=$GH_TOKEN
	npm_token=$NPM_TOKEN

	gitter_badge="<a href=\"https://gitter.im/$github_slug?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge\"><img src=\"https://badges.gitter.im/Join%20Chat.svg\" alt=\"Join the chat at https://gitter.im/$github_slug\"></a>"
	travis_badge="<a href=\"https://travis-ci.org/$github_slug\"><img src=\"https://travis-ci.org/$github_slug.svg?branch=master\" alt=\"Build Status\"></a>"
	coveralls_badge="<a href=\"https://coveralls.io/github/$github_slug?branch=master\"><img src=\"https://coveralls.io/repos/$github_slug/badge.svg?branch=master&service=github\" alt=\"Coverage Status\"></a>"
	saucelabs_small_badge="<a href=\"https://saucelabs.com/u/$github_account\"><img src=\"https://saucelabs.com/buildstatus/$github_account\" alt=\"Sauce Test Status\"></a>"
	saucelabs_big_badge="[![Sauce Test Status](https://saucelabs.com/browser-matrix/$github_account.svg)](https://saucelabs.com/u/$github_account)"
	david_dep_badge="<a href=\"https://david-dm.org/$github_slug#info=dependencies&view=table\"><img src=\"https://david-dm.org/$github_slug.svg\" alt=\"Dependencies\"></a>"
	david_devdep_badge="<a href=\"https://david-dm.org/$github_slug#info=devDependencies&view=table\"><img src=\"https://david-dm.org/$github_slug/dev-status.svg\" alt=\"Dev Dependencies\"></a>"
	license_badge="<a href=\"LICENSE\"><img src=\"http://img.shields.io/badge/license-MIT-blue.svg?style=flat\" alt=\"MIT License\"></a>"
	forkability_badge="<a href=\"https://basicallydan.github.io/forkability/?u=$github_account&r=$github_repo\"><img alt=\"This is a forkable respository\" src=\"https://img.shields.io/badge/forkable-yes-brightgreen.svg\"></a>"
	commitizen_badge="<a href=\"http://commitizen.github.io/cz-cli/\"><img src=\"https://img.shields.io/badge/commitizen-friendly-brightgreen.svg\" alt=\"Commitizen friendly\"></a>"
	semantic_release_badge="<a href=\"https://github.com/semantic-release/semantic-release\"><img src=\"https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg\" alt=\"semantic-release\"></a>"
	bower_badge="<a href=\"http://badge.fury.io/bo/$github_repo\"><img src=\"https://badge.fury.io/bo/$github_repo.svg\" alt=\"Bower version\"></a>"
	npm_badge="<a href=\"https://npmjs.org/package/$github_repo\"><img src=\"http://img.shields.io/npm/v/$github_repo.svg?style=flat\" alt=\"NPM version\"></a>"
	downloads_badge="<a href=\"http://npm-stat.com/charts.html?package=$github_repo\"><img src=\"http://img.shields.io/npm/dm/$github_repo.svg?style=flat\" alt=\"NPM downloads\"></a>"

	do_config
	exit 0
fi

echo ""
echo ""
echo "Welcome to the open-element-template configuration!"
echo "Over the next 5 minutes, this script will ask your for" 
echo "all the information you need to create your new elemnt."
echo ""
echo "This script will self-destruct after you are done, so"
echo "you only get one shot at it. But it's okay, you can"
echo "always press 'control-c' or clone the repository again"
echo "to start over."
echo ""
read -n 1 -p "Would you like to get started now? [y/N] " start
echo ""
echo ""

if [ "$start" != "y" -a "$start" != "Y" ]; then
	echo "Bummer! Come back later when you are ready."
	exit 0;
fi

echo ""
echo "Great! Let's get started."
echo ""

#####
# Basic Info
#####
echo "First, let's start with some basic information:"
while [ "$project_name" == "" ]; do
	read -p "Please enter the name for your project (e.g. - for the top of your README file): " project_name
done

while [ "$hasdash" == "" ]; do
	read -p "What are you going to name your new HTML element? (must contain a dash '-') " element_name
	hasdash=`echo $element_name | grep -`
done

read -p "Enter a description of your element for npm, bower, etc.: " element_desc
#read -p "Keywords for your element (comma separated): " element_keywords

# Basic info:
default_git_username=`git config --get user.name`
default_git_email=`git config --get user.email`


read -p "Your git name: [$default_git_username] " git_username
if [ "$git_username" == "" ]; then
	git_username=$default_git_username
fi
read -p "Your git email: [$default_git_email] " git_email
if [ "$git_email" == "" ]; then
	git_email=$default_git_email
fi

#####
# Browser
#####
echo "Some steps of this script may require you to open"
echo "a web browser to create an account for a service"
echo "or to get information about your existing accounts."
echo ""
read -n 1 -p "Would you like this script to automatically open a browser to the right URL for you? [Y/n] " browser
echo ""
echo ""

if [ "$browser" == "" -o "$browser" == "Y" ]; then
	browser="y"
fi

#####
# GitHub
#####
echo "You will need a new repository that will serve as "
echo "the home for your project. Please login to GitHub"
echo "and create a new repository."
open_browser 3 "https://github.com/new"

url_regex='^https?:\/\/github\.com\/[^\/]+\/[^\/]+(.git)?$'
while [[ ! $github_repo_url =~ $url_regex ]]; do
	read -p "Enter the URL for your new repo: " github_repo_url
	if [[ ! $github_repo_url =~ $url_regex ]]; then
		echo ""
		echo "Invalid GitHub repository URL. Expected something like:"
		echo "https://github.com/apowers313/open-element-template"
		echo ""
	fi
done

default_github_slug=`echo $github_repo_url | cut -d/ -f4-5 | cut -d. -f1`
default_github_account=`echo $default_github_slug | cut -d/ -f1`
default_github_repo=`echo $default_github_slug | cut -d/ -f2`
read -p "GitHub account: [$default_github_account] " github_account
if [ "$github_account" == "" ]; then
	github_account=$default_github_account
fi
read -p "GitHub repo: [$default_github_repo] " github_repo
if [ "$github_repo" == "" ]; then
	github_repo=$default_github_repo
fi
github_slug="$github_account/$github_repo"
echo ""

#####
# NPM
#####
function create_npm_token
{
	echo "It appears that you aren't currently logged into a NPM account."
	echo "You will need to login so that we can retrieve your NPM token"
	echo "From your .npmrc file."
	echo ""
	echo "Running 'npm adduser':"
	npm adduser
	echo "Done"
}

guid_regex='^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$'
if [ -e ~/.npmrc ]; then
	# grep for token
	npm_token=`grep authToken ~/.npmrc | cut -d= -f2`
	if [[ ! $npm_token =~ $guid_regex ]]; then
		create_npm_token
	fi
else
	create_npm_token
	npm_token=`grep authToken ~/.npmrc | cut -d= -f2`
fi
if [[ ! $npm_token =~ $guid_regex ]]; then 
	echo "ERROR: we couldn't get the NPM token from your ~/.npmrc"
	echo "We really need it... so we are exiting now."
	echo "Bummer! Email me if you need help: apowers@ato.ms" 
fi

#####
# Travis CI
#####
echo "You will need to use Travis CI for Continuous Integration"
echo "Please login to Travis CI." 
echo "(Create a new account if you don't already have one)."
open_browser 5 "https://travis-ci.org/profile/$github_account"

read -n 1 -p "Did you login to Travis CI? [Y/n] " travis_login_ok
echo ""
echo ""

if [ "$travis_login_ok" == "n" -o "$travis_login_ok" == "N" ]; then
	echo "Bummer! Email me if you need help: apowers@ato.ms"
	exit 0;
fi

echo "Now you will need to turn on your new repository."
echo "Find $github_slug in the list and click on the grey 'x'"
echo "so that it becomes a green checkmark."
open_browser 5 "https://travis-ci.org/profile/$github_account"

read -n 1 -p "Did you add $github_slug to Travis CI? [Y/n] " travis_ok
echo ""
echo ""

if [ "$travis_ok" == "n" -o "$travis_ok" == "N" ]; then
	echo "Bummer! Email me if you need help: apowers@ato.ms"
	exit 0;
fi

#####
# SauceLabs
#####
read -n 1 -p "Would you like to use SauceLabs for cross-browser testing? [Y/n] " use_saucelabs
echo ""
echo ""

if [ "$use_saucelabs" != "n" -o "$use_saucelabs" != "N" ]; then
	echo "Please create an account at SauceLabs."
	open_browser 3 "https://saucelabs.com/signup/plan/OSS"

	read -n 1 -p "Did you create an account at SauceLabs? [Y/n] " saucelabs_account_ok
	echo ""
	echo ""

	if [ "$saucelabs_account_ok" == "n" -o "$saucelabs_account_ok" == "N" ]; then
		echo "Bummer! Email me if you need help: apowers@ato.ms"
		exit 0;
	fi

	echo "Enter your SauceLabs Access Key. You can find the key"
	echo "on the left-hand side of the page underneath your account"
	echo "information."
	open_browser 3 "https://saucelabs.com/account/profile"

	while [[ ! $saucelabs_account_key =~ $guid_regex ]]; do
		read -p "Please enter your SauceLabs Account Key: " saucelabs_account_key
		if [[ ! $saucelabs_account_key =~ $guid_regex ]]; then
			echo "Not a valid SauceLabs key. Expected something like:"
			echo "f0e1d2c3-1a2b-0bad-c0de-0a1b2c3d4e5f"
		fi
	done
	echo ""
fi

#####
# GitHub Pages
#####
read -n 1 -p "Would you like to use GitHub Pages to store your documentation? [Y/n] " use_github_pages
echo ""
echo ""

if [ "$use_github_pages" != "n" -o "$use_github_pages" != "N" ]; then
	echo "You will need to create a GitHub Personal Access Token so"
	echo "that Travis can push your docs to GitHub. Please create"
	echo "a new GitHub Personal Access Token."
	echo ""
	echo "(The default options and scopes should work fine.)"
	open_browser 5 "https://github.com/settings/tokens/new"

	github_token_regex='^[0-9A-Fa-f]{40}$'
	while [[ ! $github_token =~ $github_token_regex ]]; do
		read -p "Please enter your GitHub Personal Access Token: " github_token
		echo ""
		if [[ ! $github_token =~ $github_token_regex ]]; then
			echo "Not a valid GitHub Personal Access Token. Expected something like:"
			echo "f0e1d2c31a2b0badc0de0a1b2c3d4e5fabc12342"
			echo ""
		fi
	done
fi

#####
# Coveralls
#####
read -n 1 -p "Would you like to use Coveralls to store your code coverage information? [Y/n] " use_coveralls
echo ""
echo ""

if [ "$use_coveralls" != "n" -o "$use_coveralls" != "N" ]; then
	echo "You need to create a Coveralls account -- it's free!"
	open_browser 3 "https://coveralls.io/sign-up"

	read -n 1 -p "Did you login to Coveralls? [Y/n] " coveralls_login_ok
	echo ""
	echo ""

	if [ "$coveralls_login_ok" == "n" -o "$coveralls_login_ok" == "N" ]; then
		echo "Bummer! Email me if you need help: apowers@ato.ms"
		exit 0;
	fi

	echo "Now you will need to add $github_slug to Coveralls. Find $github_slug"
	echo "in the list and click the grey 'off' button so that it turns"
	echo "into a green 'on' button."
	echo ""
	echo "It may take a minute or two for Coveralls to see your new repo..."
	echo "(Hit refresh if you get bored)"
	open_browser 5 "https://coveralls.io/refresh"

	read -n 1 -p "Did you add $github_slug to Coveralls? [Y/n] " coveralls_ok
	echo ""
	echo ""

	if [ "$coveralls_ok" == "n" -o "$coveralls_ok" == "N" ]; then
		echo "Bummer! Email me if you need help: apowers@ato.ms"
		exit 0;
	fi
fi

#####
# Badges
#####
echo "Now you get to select which badges you want in your README.md."
echo "Don't worry, you can delete them later if you don't want them."
echo ""

read -n 1 -p "Gitter Badge (enables online chat for your project)? [Y/n] " gitter_badge
echo ""
echo ""
if [ "$gitter_badge" != "n" -a "$gitter_badge" != "N" ]; then
	gitter_badge="<a href=\"https://gitter.im/$github_slug?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge\"><img src=\"https://badges.gitter.im/Join%20Chat.svg\" alt=\"Join the chat at https://gitter.im/$github_slug\"></a>"
fi

read -n 1 -p "Travis CI Build Status Badge? [Y/n] " travis_badge
echo ""
echo ""
if [ "$travis_badge" != "n" -a "$travis_badge" != "N" ]; then
	travis_badge="<a href=\"https://travis-ci.org/$github_slug\"><img src=\"https://travis-ci.org/$github_slug.svg?branch=master\" alt=\"Build Status\"></a>"
fi

if [ "$use_coveralls" != "n" -o "$use_coveralls" != "N" ]; then
	read -n 1 -p "Coveralls Code Coverage Badge? [Y/n] " coveralls_badge
	echo ""
	echo ""
	if [ "$coveralls_badge" != "n" -a "$coveralls_badge" != "N" ]; then
		coveralls_badge="<a href=\"https://coveralls.io/github/$github_slug?branch=master\"><img src=\"https://coveralls.io/repos/$github_slug/badge.svg?branch=master&service=github\" alt=\"Coverage Status\"></a>"
	fi
fi

if [ "$use_saucelabs" != "n" -o "$use_saucelabs" != "N" ]; then
	read -n 1 -p "SauceLabs Build Status Small Badge? [Y/n] " saucelabs_small_badge
	echo ""
	echo ""
	if [ "$saucelabs_small_badge" != "n" -a "$saucelabs_small_badge" != "N" ]; then
		saucelabs_small_badge="<a href=\"https://saucelabs.com/u/$github_account\"><img src=\"https://saucelabs.com/buildstatus/$github_account\" alt=\"Sauce Test Status\"></a>"
	fi

	read -n 1 -p "SauceLabs Build Status Big Badge (a matrix of test status against all browsers)? [Y/n] " saucelabs_big_badge
	echo ""
	echo ""
	if [ "$saucelabs_big_badge" != "n" -a "$saucelabs_big_badge" != "N" ]; then
		saucelabs_big_badge="[![Sauce Test Status](https://saucelabs.com/browser-matrix/$github_account.svg)](https://saucelabs.com/u/$github_account)"
	fi
fi

read -n 1 -p "David DM Dependencies Badge? [Y/n] " david_dep_badge
echo ""
echo ""
if [ "$david_dep_badge" != "n" -a "$david_dep_badge" != "N" ]; then
	david_dep_badge="<a href=\"https://david-dm.org/$github_slug#info=dependencies&view=table\"><img src=\"https://david-dm.org/$github_slug.svg\" alt=\"Dependencies\"></a>"
fi

read -n 1 -p "David DM Development Dependencies Badge? [Y/n] " david_devdep_badge
echo ""
echo ""
if [ "$david_devdep_badge" != "n" -a "$david_devdep_badge" != "N" ]; then
	david_devdep_badge="<a href=\"https://david-dm.org/$github_slug#info=devDependencies&view=table\"><img src=\"https://david-dm.org/$github_slug/dev-status.svg\" alt=\"Dev Dependencies\"></a>"
fi

read -n 1 -p "License Badge? [Y/n] " license_badge
echo ""
echo ""
if [ "$license_badge" != "n" -a "$license_badge" != "N" ]; then
	license_badge="<a href=\"LICENSE\"><img src=\"http://img.shields.io/badge/license-MIT-blue.svg?style=flat\" alt=\"MIT License\"></a>"
fi

read -n 1 -p "Forkability Badge? [Y/n] " forkability_badge
echo ""
echo ""
if [ "$forkability_badge" != "n" -a "$forkability_badge" != "N" ]; then
	forkability_badge="<a href=\"https://basicallydan.github.io/forkability/?u=$github_account&r=$github_repo\"><img alt=\"This is a forkable respository\" src=\"https://img.shields.io/badge/forkable-yes-brightgreen.svg\"></a>"
fi

read -n 1 -p "Commitizen Badge? [Y/n] " commitizen_badge
echo ""
echo ""
if [ "$commitizen_badge" != "n" -a "$commitizen_badge" != "N" ]; then
	commitizen_badge="<a href=\"http://commitizen.github.io/cz-cli/\"><img src=\"https://img.shields.io/badge/commitizen-friendly-brightgreen.svg\" alt=\"Commitizen friendly\"></a>"
fi

read -n 1 -p "Semantic Release Badge? [Y/n] " semantic_release_badge
echo ""
echo ""
if [ "$semantic_release_badge" != "n" -a "$semantic_release_badge" != "N" ]; then
	semantic_release_badge="<a href=\"https://github.com/semantic-release/semantic-release\"><img src=\"https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg\" alt=\"semantic-release\"></a>"
fi

read -n 1 -p "Bower Version Badge? [Y/n] " bower_badge
echo ""
echo ""
if [ "$bower_badge" != "n" -a "$bower_badge" != "N" ]; then
	bower_badge="<a href=\"http://badge.fury.io/bo/$github_repo\"><img src=\"https://badge.fury.io/bo/$github_repo.svg\" alt=\"Bower version\"></a>"
fi

read -n 1 -p "NPM Version Badge? [Y/n] " npm_badge
echo ""
echo ""
if [ "$npm_badge" != "n" -a "$npm_badge" != "N" ]; then
	npm_badge="<a href=\"https://npmjs.org/package/$github_repo\"><img src=\"http://img.shields.io/npm/v/$github_repo.svg?style=flat\" alt=\"NPM version\"></a>"
fi

read -n 1 -p "NPM Downloads Badge? [Y/n] " downloads_badge
echo ""
echo ""
if [ "$downloads_badge" != "n" -a "$downloads_badge" != "N" ]; then
	downloads_badge="<a href=\"http://npm-stat.com/charts.html?package=$github_repo\"><img src=\"http://img.shields.io/npm/dm/$github_repo.svg?style=flat\" alt=\"NPM downloads\"></a>"
fi


sleep 1

# print options
echo ""
echo "  Your Configuration"
echo "======================"
echo "Project Name: " $project_name
echo "Element Name: " $element_name
echo "Element Description: " $element_desc
echo "GitHub Account: " $github_account
echo "GitHub Repo: " $github_repo
echo "GitHub Slug: " $github_slug
echo "Git Username: " $git_username
echo "Git Email: " $git_username
# Removing so that they don't end up in Travis CI logs
# echo "SauceLabs Account Key: " $saucelabs_account_key
# echo "GitHub Personal Access Token: " $github_token
echo ""
echo "*** Please read this over carefully -- after you move on, there is no going back ***"
echo "(unless you clone the repo again)"
echo ""
read -n 1 -p "Are you ready to save your configuration? [Y/n] " finished
echo ""
echo ""

if [ "$finished" != "y" -a "$finished" != "Y" -a "$finished" != "" ]; then
	echo "Argh! All that work and you don't want to save? FINE! I'm outta here."
	exit 0
fi

# this is where the real work gets done
do_config

#####
# Commit
#####
read -n 1 -p "Done configuring, would you like to commit and push to GitHub now? [y/N] " commit_and_push
echo ""
echo ""

if [ "$commit_and_push" == "y" -o "$commit_and_push" == "Y" ]; then
	run_cmd "github commit -am 'Initial commit'"
	run_cmd "github push origin master"
fi


