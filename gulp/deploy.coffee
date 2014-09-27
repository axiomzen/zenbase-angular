gulp = require 'gulp'
plgn = require('gulp-load-plugins')()
paths = require './paths'

###
# Deploy Tasks
# Deploys from dist/
###

gulp.task 'deploy', ->
  gulp.src paths.deploy
    .pipe plgn.ghPages()
