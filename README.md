[![Join the chat at https://gitter.im/apowers313/open-element-template](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/apowers313/open-element-template?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Build Status][http://img.shields.io/travis/apowers313/open-element-template/develop.svg?style=flat]][http://travis-ci.org/apowers313/open-element-template]
[![Dependencies][https://david-dm.org/apowers313/open-element-template.svg]][https://david-dm.org/apowers313/open-element-template]
[![Dev Dependencies][https://david-dm.org/apowers313/open-element-template/dev-status.svg]][https://david-dm.org/apowers313/open-element-template]
[![NPM version][http://img.shields.io/npm/v/open-element-template.svg?style=flat]][https://npmjs.org/package/open-element-template]
[![NPM downloads][http://img.shields.io/npm/dm/open-element-template.svg?style=flat]][https://npmjs.org/package/open-element-template]
[![MIT License][http://img.shields.io/badge/license-MIT-blue.svg?style=flat]][LICENSE]
<!-- [![Coverage Status](https://coveralls.io/repos/apowers313/open-element-template/badge.svg?branch=master)](https://coveralls.io/r/apowers313/open-element-template?branch=master) -->

---------------------------------------
Delete everything below this line after forking or cloning

# About
Much like [Polymer boilerplate](https://github.com/webcomponents/polymer-boilerplate), [Polymer seed-element](https://github.com/polymerelements/seed-element), [generator element](https://github.com/webcomponents/generator-element), and others, this is a template for starting new projects. Sorry for calling it "template", since that broadly means something else for web components.

So why another template for Polymer elements? This one has two ideas behind it:
1. It makes use of all the services that support open source projects, such as Travis for testing, SauceLabs for cross-browser testing, some badges and other stuff. Figuring out how to setup and integrate these services can take time and isn't fun or productive.
2. If you fork or clone from this repository, you can merge in new services and features into your component as they become available. You don't have to figure it out, just `git pull` to merge in the new features and you will get anything new that has been added. This can be new features, new documentation, new badges, etc.

# Features
* Web Component Testing setup and configuration
* Travis CI configuration file
* SauceLabs integration for multi-browser testing
* Code coverage using Istanbul and Coveralls
* `web-components` keyword for inclusion on customelements.io
* Nifty badges already included for build status, test coverage, dependency status, and Gitter
* Forking this repo means that as new features are added, they can be included in your project with a simple `git pull` request

# Setup Services
1. Fork this repo
	* Click `Fork` in the top right-hand corner of this webpage
1. Travis CI
	* Login using Githubaccount by clicking `Sign in with GitHub` in the top right-hand corner of [Travis CI webpage](https://travis-ci.org/) 
	* Click `+` next to `Repositories`
	* Turn on Travis CI for your fork
2. SauceLabs
	* [Create account](https://saucelabs.com/signup/plan/OSS)
	* Add secret keys to .travis.yml by following [this link](https://docs.saucelabs.com/ci-integrations/travis-ci/)
<!-- 3. Coveralls
	* Create account
	* Link with Travis CI -->

# Things to Try
* `npm test`
* `npm run debug`
* `npm run testdebug`
* `npm demo`

# Updating
Are there new features in this repo that you wish you had? If you forked or cloned from this project, here's how to merge them into your project:
1. `cd YourProject` -- get ready...
2. `git checkout master` -- make sure your project is up to date and you are working on the master branch
3. `git pull https://github.com/apowers313/<this repo> master` -- fetch and merge the latest version of this project into your master branch
4. If necessary, resolve any merge conflicts. For help, [check this out](https://help.github.com/articles/resolving-a-merge-conflict-from-the-command-line/)
https://help.github.com/articles/merging-an-upstream-repository-into-your-fork/
5. `git commit -am 'Merged latest version of <this repo>'` -- commit merge changes
6. `git push origin master` -- push the entire project back to GitHub