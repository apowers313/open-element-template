# Open Element Template
[![Join the chat at https://gitter.im/apowers313/open-element-template](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/apowers313/open-element-template?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)  [![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)  [![NPM version](http://img.shields.io/npm/v/open-element-template.svg?style=flat)](https://npmjs.org/package/open-element-template)  [![NPM downloads](http://img.shields.io/npm/dm/open-element-template.svg?style=flat)](https://npmjs.org/package/open-element-template)

[![Build Status](https://travis-ci.org/apowers313/open-element-template.svg?branch=master)](https://travis-ci.org/apowers313/open-element-template)  [![Coverage Status](https://coveralls.io/repos/apowers313/open-element-template/badge.svg?branch=master&service=github)](https://coveralls.io/github/apowers313/open-element-template?branch=master)  [![Sauce Test Status](https://saucelabs.com/buildstatus/apowers313)](https://saucelabs.com/u/apowers313)  [![Dependencies](https://david-dm.org/apowers313/open-element-template.svg)](https://david-dm.org/apowers313/open-element-template#info=dependencies&view=table)  [![Dev Dependencies](https://david-dm.org/apowers313/open-element-template/dev-status.svg)](https://david-dm.org/apowers313/open-element-template#info=devDependencies&view=table)  



[![Sauce Test Status](https://saucelabs.com/browser-matrix/apowers313.svg)](https://saucelabs.com/u/apowers313)


---------------------------------------
Delete everything below this line after forking or cloning

## About
Much like [Polymer boilerplate](https://github.com/webcomponents/polymer-boilerplate), [Polymer seed-element](https://github.com/polymerelements/seed-element), [generator element](https://github.com/webcomponents/generator-element), and others, this is a template for starting new projects. Sorry for calling it "template", since that broadly means something else for web components.

So why another template for Polymer elements? This one has three ideas behind it:

1. It makes use of all the services that support open source projects, such as [Travis](https://travis-ci.org/) for testing, [SauceLabs](https://saucelabs.com/home) for cross-browser testing, some badges and other stuff. Figuring out how to setup and integrate these services can take time and isn't fun or productive.
2. If you fork or clone from this repository, you can merge in new services and features into your component as they become available. You don't have to figure it out, just `git pull` to merge in the new features and you will get anything new that has been added. This can be new features, new documentation, new badges, etc.
3. You are probably going to have a lot of similar web components and trying to maintain their core structure is going to be a boring waste of time. Wouldn't it be great if they can all share a common structure and be updated in an easy and effective way?

## Features
* [Travis CI](https://travis-ci.org/) integration for automatic testing
* [SauceLabs](https://saucelabs.com/home) integration for multi-browser testing
* [Web Component Tester](https://github.com/Polymer/web-component-tester) for Polymer testing
* [YUIDoc](http://yui.github.io/yuidoc/) for document generation
* [GitHub Pages](https://pages.github.com/) for hosted API documentation, for example see the [sample docs for open-element-template](http://apowers313.github.io/open-element-template/)
* [Istanbul](https://gotwarlost.github.io/istanbul/) and [WCTI](https://www.npmjs.com/package/web-component-tester-istanbul) code coverage, for exmaple see the [code coverage report for open-element-template](http://apowers313.github.io/open-element-template/coverage). (Currently only works for .js files, not JavaScript embedded in HTML)
* [customelements.io](https://customelements.io/) keywords to publish the element where people can see it
* [David](https://david-dm.org/) dependency status
* [Gitter](https://gitter.im) for online conversation about your element
* Nifty badges for many of the projects above
* Forking this repo means that as new features are added, they can be included in your project with a simple `git pull` request

__If there are features or services that you think should be here, I am happy to take requests. Feel free to [submit an issue](https://github.com/apowers313/open-element-template/issues) or send in a pull request.__ 

## Setup Services
Here's what you do to build your own element based off of this template. Forking or cloning is the easy part, and then setting up an account on each of the services below shouldn't take more than 10 minutes.

1. Fork this repo
	* Click `Fork` in the top right-hand corner of [this webpage](https://github.com/apowers313/open-element-template)
	* Or `clone` the repo by running the following commands:
		* Create a new repository called `new-project` on GitHub
		* `mkdir new-project && cd new-project` -- make your new project directory
		* `git clone https://github.com/apowers313/open-element-template.git .` -- clone it into the current (empty) directory of your new project (note the trailing '.')
		* `git remote set-url origin https://github.com/yourname/new-project.git` -- change your GitHub remote to your project on GitHub
		* `git push origin master` -- push the tempalte up to your repository
	* Optionally: Watch this GitHub repo by clicking the `Watch` button in the top-right hand corner of [this webpage](https://github.com/apowers313/open-element-template) so that you will be informed of changes as they occur.
1. Travis CI
	* Login using Githubaccount by clicking `Sign in with GitHub` in the top right-hand corner of [Travis CI webpage](https://travis-ci.org/) 
	* Click `+` next to `Repositories`
	* Turn on Travis CI for your fork
1. SauceLabs
	* [Create account](https://saucelabs.com/signup/plan/OSS)
	* Add secret keys to .travis.yml by following [this link](https://docs.saucelabs.com/ci-integrations/travis-ci/)
	* Optionally: `export SAUCE_USERNAME=<your username>; export SAUCE_ACCESS_KEY=<your key>` -- set key as an SAUCE_USERNAME and SAUCE_ACCESS_KEY environment variables if you ever want to run `npm test` locally. Add them to your `~/.profile` if you want to always have them set.
1. GitHub Pages
	* `npm run create-travis-deploy-key` -- this command will open up a browser to the [GitHub New Personal Token Page](https://github.com/settings/tokens/new) and prompt you to enter it on the command line. The default scopes and options for the GitHub personal token should be fine. After the command completes, you should have a new line in your `.travis.yml` file that contains the encrypted GitHub token.
	* `git commit .travis.yml -m "Added GitHub pages key"` -- commit the new Travis config
	* `git push origin master` -- push the new Travis config up to GitHub, which should trigger a new build and push the docs folder to GitHub Pages. You should be able to see your docs at: http://<YOUR NAME>.github.io/<YOUR PROJECT>/ . For example, see the [docs for the open-element-template](http://apowers313.github.io/open-element-template/). Note, docs will only deploy if the tests ran successfully.
	* Optionally: `export GITHUB_TOKEN=<your GitHub token>` -- set key as an environment variable if you ever want to run `npm deploydocs` locally. Add it to your `~/.profile` if you want to always have it set.

## Things to Try
* `npm test` -- uses the [web component tester](https://github.com/Polymer/web-component-tester) to open browsers at SauceLabs and test your element on each of them (requires SAUCE_USERNAME and SAUCE_ACCESS_KEY environment variables to be set, see above)
* `npm run demo` -- shows your new element in action
* `npm run testdebug` -- runs a single pass of the tests using your local copy of Chrome, and keeps Chrome open so that you can see the debug console and refresh to re-run tests
* `npm run localtest` -- runs tests in all browsers that are installed on your system
* `npm run viewcoverage` -- view your code coverage report (caveats: requires a successful test run, currently only works for standalone .js files, not JavaScript embedded in .html files)
* `npm run docs` -- generate docs for your components and store them in the ./docs directory
* `npm run deploydocs` -- deploy your documentation to GitHub (requires that the `GITHUB_TOKEN` environment variable be set to your GitHub personal token, created above)
* `npm run testdocs` -- generate docs for your components, and fire up a webserver and a browser to view them -- great for testing your docs as you are writing them
* Check in your code to automatically test it, build documentation, and deploy documentation

## How to Make This Your Own
1. Edit [open-element.html](open-element.html). Add some HTML between the `<template>` tags to include new HTML in your element. Customize the `Polymer()` JavaScript to add new properties or functionality to your element. Want some help getting started? Check out the [Polymer Developer Guide](https://www.polymer-project.org/1.0/docs/devguide/feature-overview.html) or see some examples from the [polymer-example-element](https://github.com/apowers313/polymer-example-element).
2. Now if you run `npm run demo` you'll see your changes. And if you run `npm test` you'll notice... whoops! You broke the tests! Edit [test/open-element.html](test/open-element.html) to update your tests. Tests are using the [Web Component Tester](https://github.com/Polymer/web-component-tester), which uses [Mocha](http://mochajs.org/) as a test framework, [Chai](http://chaijs.com/) for assertions, and [Sinon](http://sinonjs.org/) for other stuff -- especially mocking servers. Don't forget to use `npm run testdebug` if your tests aren't doing what you expect.
3. Repeat #1 and #2 until you have something cool. Or #2 then #1. It's up to you. Have fun!
4. Edit [package.json](package.json), [bower.json](bower.json), [yuidoc.json](yuidoc.json), and [deploy-docs.sh](deploy-docs.sh) to describe your package, use your email address, your version, etc.
5. Edit [README.md](README.md) and [LICENSE](LICENSE) to your liking. Don't forget to change the URLs for all the badges in the README if you intend to use them!
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