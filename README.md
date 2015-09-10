# Open Element Template

<table>
	<tr> 
		<td>Chat</td> <td colspan=3><a href="https://gitter.im/apowers313/open-element-template?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge"><img src="https://badges.gitter.im/Join%20Chat.svg" alt="Join the chat at https://gitter.im/apowers313/open-element-template"></a></td> 
	</tr>
	<tr>
		<td>Package</td> <td><a href="https://npmjs.org/package/open-element-template"><img src="http://img.shields.io/npm/v/open-element-template.svg?style=flat" alt="NPM version"></a></td> <td><a href="http://badge.fury.io/bo/open-element-template"><img src="https://badge.fury.io/bo/open-element-template.svg" alt="Bower version"></a>
</td>  <td><a href="https://npmjs.org/package/open-element-template"><img src="http://img.shields.io/npm/dm/open-element-template.svg?style=flat" alt="NPM downloads"></a></td> 
	</tr>
	<tr>
		<td>Dependencies</td> <td><a href="https://david-dm.org/apowers313/open-element-template#info=dependencies&view=table"><img src="https://david-dm.org/apowers313/open-element-template.svg" alt="Dependencies"></a></td> <td><a href="https://david-dm.org/apowers313/open-element-template#info=devDependencies&view=table"><img src="https://david-dm.org/apowers313/open-element-template/dev-status.svg" alt="Dev Dependencies"></a></td> <td></td> 
	</tr>
	<tr> 
		<td>Build</td> <td><a href="https://travis-ci.org/apowers313/open-element-template"><img src="https://travis-ci.org/apowers313/open-element-template.svg?branch=master" alt="Build Status"></a></td> <td><a href="https://saucelabs.com/u/apowers313"><img src="https://saucelabs.com/buildstatus/apowers313" alt="Sauce Test Status"></a></td> <td><a href="https://coveralls.io/github/apowers313/open-element-template?branch=master"><img src="https://coveralls.io/repos/apowers313/open-element-template/badge.svg?branch=master&service=github" alt="Coverage Status"></a></td> 
	</tr>
	<tr> 
		<td>Release</td> <td><a href="LICENSE"><img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="MIT License"></a>
</td> <td><a href="http://commitizen.github.io/cz-cli/"><img src="https://img.shields.io/badge/commitizen-friendly-brightgreen.svg" alt="Commitizen friendly"></a></td> <td><a href="https://github.com/semantic-release/semantic-release"><img src="https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg" alt="semantic-release"></a></td> 
	</tr>
</table>

Browser Support<br>
[![Sauce Test Status](https://saucelabs.com/browser-matrix/apowers313.svg)](https://saucelabs.com/u/apowers313)

---------------------------------------

## About
Want to create your own custom HTML tag? Big fan of open source? Enjoy it when you have a mature development process? This is the project for you...

Much like [Polymer boilerplate](https://github.com/webcomponents/polymer-boilerplate), [Polymer seed-element](https://github.com/polymerelements/seed-element), [generator element](https://github.com/webcomponents/generator-element), and others, this is a template for creating new custom web elements. (Sorry for calling it "template" -- I realize that has other meanings for web components.)

So why another template for Polymer elements? This one has three ideas behind it:

1. It has __built-in support__ for the most important __services that are free open source projects__
, such as [Travis](https://travis-ci.org/) for testing, [SauceLabs](https://saucelabs.com/home) for cross-browser testing, some badges and other stuff. Figuring out how to setup and integrate these services can take time and isn't fun or productive.
2. If you fork or clone from this repository, you can merge in new services and features into your component as they become available. You don't have to figure it out, just `git pull` to __merge in new features and services__ and you will get anything new that has been added. This can be new features, new documentation, new badges, etc.
3. You are probably going to have a lot of __similar web components__ and trying to maintain their __core structure__ is going to be a boring waste of time. Wouldn't it be great if they can all share a common structure and be updated in an easy and effective way?

## Features
* [Travis CI](https://travis-ci.org/) integration for automatic testing
* [SauceLabs](https://saucelabs.com/home) integration for multi-browser testing
* [Web Component Tester](https://github.com/Polymer/web-component-tester) for Polymer testing
* [YUIDoc](http://yui.github.io/yuidoc/) for document generation
* [GitHub Pages](https://pages.github.com/) for hosted API documentation, for example see the [sample docs for open-element-template](http://apowers313.github.io/open-element-template/)
* [Istanbul](https://gotwarlost.github.io/istanbul/) and [WCTI](https://www.npmjs.com/package/web-component-tester-istanbul) code coverage, for exmaple see the [code coverage report for open-element-template](http://apowers313.github.io/open-element-template/coverage). (Currently only works for .js files, not JavaScript embedded in HTML)
* [Coveralls](https://coveralls.io/) code coverage reporting, based on the Istanbul report
* [semantic-release](https://github.com/semantic-release/semantic-release) for automatic versioning, change log creation, and publishing
* [Commitizen](http://commitizen.github.io/cz-cli/) for conventional commit messages and change logs
* [customelements.io](https://customelements.io/) keywords to publish the element where people can see it
* [David](https://david-dm.org/) dependency status
* [Gitter](https://gitter.im) for online conversation about your element
* Nifty badges for many of the projects above
* Forking this repo means that as new features are added, they can be included in your project with a simple `git pull` request

__If there are features or services that you think should be here, I am happy to take requests. Feel free to [submit an issue](https://github.com/apowers313/open-element-template/issues) or send in a pull request.__ 

## Install

	npm install open-element-template

...but you already knew that, right? The trick here is that there is a postinstall script that runs through a series of questions to configure all the services. This involves setting up a new repo on GitHub, enabling builds on Travis CI, and optionally setting up other services. It then overwrites the files in this package with configuration files that tie together all the services. It's awesome when you have a configuration management system that just works together. Especially when you don't have to spend two weeks setting it up.

## Things to Try After You Install
* `npm test` -- uses the [web component tester](https://github.com/Polymer/web-component-tester) to open browsers at SauceLabs and test your element on each of them (requires SAUCE_USERNAME and SAUCE_ACCESS_KEY environment variables to be set, see above)
* `npm run demo` -- shows your new element in action
* `npm run testdebug` -- runs a single pass of the tests using your local copy of Chrome, and keeps Chrome open so that you can see the debug console and refresh to re-run tests
* `npm run localtest` -- runs tests in all browsers that are installed on your system
* `npm run viewcoverage` -- view your code coverage report (caveats: requires a successful test run, currently only works for standalone .js files, not JavaScript embedded in .html files)
* `npm run docs` -- generate docs for your components and store them in the ./docs directory
* `npm run deploydocs` -- deploy your documentation to GitHub (requires that the `GH_TOKEN` environment variable be set to your GitHub personal token, created above)
* `npm run testdocs` -- generate docs for your components, and fire up a webserver and a browser to view them -- great for testing your docs as you are writing them
* `npm run config` -- if you didn't complete configuration during installation, this is how you can kick it off again
* `git cz -a` -- commit all changes using Commitizen
* Check in your code to automatically test it, build documentation, and deploy documentation

## How to Develop Your Custom Element
1. Edit [open-element.html](open-element.html). Add some HTML between the `<template>` tags to include new HTML in your element. Customize the `Polymer()` JavaScript to add new properties or functionality to your element. Want some help getting started? Check out the [Polymer Developer Guide](https://www.polymer-project.org/1.0/docs/devguide/feature-overview.html) or see some examples from the [polymer-example-element](https://github.com/apowers313/polymer-example-element).
1. Now if you run `npm run demo` you'll see your changes. And if you run `npm test` you'll notice... whoops! You broke the tests! Edit [test/open-element.html](test/open-element.html) to update your tests. Tests are using the [Web Component Tester](https://github.com/Polymer/web-component-tester), which uses [Mocha](http://mochajs.org/) as a test framework, [Chai](http://chaijs.com/) for assertions, and [Sinon](http://sinonjs.org/) for other stuff -- especially mocking servers. Don't forget to use `npm run testdebug` if your tests aren't doing what you expect.
1. Repeat #1 and #2 until you have something cool. Or #2 then #1. It's up to you. Have fun!
1. Add documents to your code. It's pretty simple, but check out the [YUIDoc Syntax Reference](http://yui.github.io/yuidoc/syntax/) if you get stuck.
1. Run `git cz -a` (make sure that you have [Commitizen](http://commitizen.github.io/cz-cli/) installed) and follow the instructions
1. `git push origin master` to push your changes back to GitHub. Watch with delight as Travis and SauceLabs test your element on a wide variety of browsers, and semantic-release automatically bumps-up your version number, creates a change log and publishes the package to npm.
1. Pat yourself on the back and drink a beer.

## Updating
Are there new features in this repo that you wish you had? If you forked or cloned from this project, here's how to merge them into your project:

1. `cd YourProject` -- get ready...
2. `git checkout master` -- make sure your project is up to date and you are working on the master branch
3. `git pull https://github.com/apowers313/open-element-template master` -- fetch and merge the latest version of this project into your master branch
4. If necessary, resolve any merge conflicts. For help, [check this out](https://help.github.com/articles/resolving-a-merge-conflict-from-the-command-line/)
https://help.github.com/articles/merging-an-upstream-repository-into-your-fork/
5. `git commit -am 'Merged latest version of open-element-template'` -- commit merge changes
6. `git push origin master` -- push the entire project back to GitHub