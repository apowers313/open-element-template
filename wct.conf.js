// For config options, refer to:
// https://github.com/Polymer/web-component-tester/blob/master/runner/config.js

// Most of the time you will want to rely on the WCT browser plugins to fill
// this in for you (e.g. via `--local`, `--sauce`, etc).
//
// Docs:
// Selenium: https://code.google.com/p/selenium/wiki/DesiredCapabilities
// Sauce:    https://docs.saucelabs.com/reference/test-configuration/

module.exports = {
    verbose: false,
    expanded: true,
    simpleOutput: true,
    plugins: {
        local: {
            // browsers: ['default']
        },
        sauce: {
            name: "{{element_name}} :: " + require("os").hostname() + " :: " + new Date().toLocaleString(),
            build: process.env.TRAVIS_BUILD_NUMBER,
            tag: process.env.TRAVIS_BRANCH || process.env.TRAVIS_PULL_REQUEST,
            disabled: false,
            // browsers: ['chrome', 'firefox', 'safari', 'ie']
        },
        "istanbul": {
            dir: "coverage",
            reporters: ["text-summary", "lcov", "html"],
            include: [
                "**/*.js"
            ],
            exclude: [
                "/polymer/polymer.js",
                "/webcomponents/webcomponents.js",
                "/bower_components/**/*.js"
            ]
        }
    },
};
