<a href="https://zenhub.io"><img src="https://raw.githubusercontent.com/ZenHubIO/support/master/zenhub-badge.png" height="18px"></a>

## Zenbase-angular

Yet another Angular boilerplate. Why? Why not! Boilerplates come in many flavours. Zenbase is intended to be light and flexible, but with a few opinionated choices up-front.

Zenbase is designed with the developer's productivity in mind. We keep things light and to the point, without an unnecessary amount of gulp plugins. This should get you coding asap.

[Live Example](http://axiomzen.github.io/zenbase-angular)

## Stack

- Gulp
- Angular
- Bower
- Coffeescript
- Stylus
- Jade


## Overview

The gulp pipelines are contained in the `/gulp` folder. All your coding should be done in `/src`. Note as well that you should not need to edit `/src/index.jade` that much. All your Javascript and CSS is concatenated, and all bower dependencies are injected automatically. Wow.

## Usage

Clone the repo; install dependencies:

```
npm install
bower install
```

- `gulp` Compile your source into `/public` and start a local server
- `gulp build` Build your app into `/dist`
- `gulp serveDist` Start a local server and serve up what you just built
- `gulp deploy` Deploys dist/ folder to gh-pages (you have to build first!)
