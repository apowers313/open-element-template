# Open Element Template
[![Join the chat at https://gitter.im/apowers313/open-element-template](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/apowers313/open-element-template?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)  [![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)
[![Build Status](https://travis-ci.org/apowers313/open-element-template.svg?branch=master)](https://travis-ci.org/apowers313/open-element-template)  [![Dependencies](https://david-dm.org/apowers313/open-element-template.svg)](https://david-dm.org/apowers313/open-element-template#info=dependencies&view=table)  [![Dev Dependencies](https://david-dm.org/apowers313/open-element-template/dev-status.svg)](https://david-dm.org/apowers313/open-element-template#info=devDependencies&view=table)  
[![NPM version](http://img.shields.io/npm/v/open-element-template.svg?style=flat)](https://npmjs.org/package/open-element-template)  [![NPM downloads](http://img.shields.io/npm/dm/open-element-template.svg?style=flat)](https://npmjs.org/package/open-element-template)  


---------------------------------------
Delete everything below this line after forking or cloning

## About
Much like [Polymer boilerplate](https://github.com/webcomponents/polymer-boilerplate), [Polymer seed-element](https://github.com/polymerelements/seed-element), [generator element](https://github.com/webcomponents/generator-element), and others, this is a template for starting new projects. Sorry for calling it "template", since that broadly means something else for web components.

So why another template for Polymer elements? This one has three ideas behind it:

1. It makes use of all the services that support open source projects, such as [Travis](https://travis-ci.org/) for testing, [SauceLabs](https://saucelabs.com/home) for cross-browser testing, some badges and other stuff. Figuring out how to setup and integrate these services can take time and isn't fun or productive.
2. If you fork or clone from this repository, you can merge in new services and features into your component as they become available. You don't have to figure it out, just `git pull` to merge in the new features and you will get anything new that has been added. This can be new features, new documentation, new badges, etc.
3. You are probably going to have a lot of similar web components and trying to maintain their core structure is going to be a boring waste of time. Wouldn't it be great if they can all share a common structure and be updated in an easy and effective way?

## Features
* [Web Component Tester](https://github.com/Polymer/web-component-tester) setup and configuration
* [Travis CI](https://travis-ci.org/) configuration file
* [SauceLabs](https://saucelabs.com/home) integration for multi-browser testing
* [YUIDoc](http://yui.github.io/yuidoc/) for inline document generation
* `web-components` keyword for inclusion on [customelements.io](https://customelements.io/)
* Nifty badges already included for build status, [David](https://david-dm.org/) dependency status, and [Gitter](https://gitter.im)
* Forking this repo means that as new features are added, they can be included in your project with a simple `git pull` request

## Setup Services
1. Fork this repo
	* Click `Fork` in the top right-hand corner of [this webpage](https://github.com/apowers313/open-element-template)
1. Travis CI
	* Login using Githubaccount by clicking `Sign in with GitHub` in the top right-hand corner of [Travis CI webpage](https://travis-ci.org/) 
	* Click `+` next to `Repositories`
	* Turn on Travis CI for your fork
2. SauceLabs
	* [Create account](https://saucelabs.com/signup/plan/OSS)
	* Add secret keys to .travis.yml by following [this link](https://docs.saucelabs.com/ci-integrations/travis-ci/)

## Things to Try
* `npm test` -- uses the [web component tester](https://github.com/Polymer/web-component-tester) to open browsers at SauceLabs and test your element on each of them
* `npm run demo` -- shows your new element in action
* `npm run testdebug` -- runs a single pass of the tests using your local copy of Chrome, and keeps Chrome open so that you can see the debug console and refresh to re-run tests
* `npm run docs` -- generate docs for your components and store them in the ./docs directory
* `npm run testdocs` -- generate docs for your components, and fire up a webserver and a browser to view them -- great for testing your docs as you are writing them

## How to Make This Your Own
1. Edit [open-element.html](open-element.html). Add some HTML between the `<template>` tags to include new HTML in your element. Customize the `Polymer()` JavaScript to add new properties or functionality to your element. Want some help getting started? Check out the [Polymer Developer Guide](https://www.polymer-project.org/1.0/docs/devguide/feature-overview.html).
2. Now if you run `npm run demo` you'll see your changes. And if you run `npm test` you'll notice... whoops! You broke the tests! Edit [test/open-element.html](test/open-element.html) to update your tests. Tests are using the [Web Component Tester](https://github.com/Polymer/web-component-tester), which uses [Mocha](http://mochajs.org/) as a test framework, [Chai](http://chaijs.com/) for assertions, and [Sinon](http://sinonjs.org/) for other stuff -- especially mocking servers. Don't forget to use `npm run testdebug` if your tests aren't doing what you expect.
3. Repeat #1 and #2 until you have something cool. Or #2 then #1. It's up to you. Have fun!
4. Edit [package.json](package.json), [bower.json](bower.json), and [yuidoc.json](yuidoc.json) to describe your package, have your email address, your version, etc.
5. Edit [README.md](README.md) and [LICENSE](LICENSE) to your liking
6. Run `git commit -am "I'm committed"` and `git push origin master` to push your changes back to GitHub. Watch with delight as Travis and SauceLabs do their thing.
7. Pat yourself on the back and drink a beer.

## Updating
Are there new features in this repo that you wish you had? If you forked or cloned from this project, here's how to merge them into your project:

1. `cd YourProject` -- get ready...
2. `git checkout master` -- make sure your project is up to date and you are working on the master branch
3. `git pull https://github.com/apowers313/open-element-template master` -- fetch and merge the latest version of this project into your master branch
4. If necessary, resolve any merge conflicts. For help, [check this out](https://help.github.com/articles/resolving-a-merge-conflict-from-the-command-line/)
https://help.github.com/articles/merging-an-upstream-repository-into-your-fork/
5. `git commit -am 'Merged latest version of open-element-template'` -- commit merge changes
6. `git push origin master` -- push the entire project back to GitHub