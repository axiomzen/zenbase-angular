gulp = require 'gulp'
plgn = require('gulp-load-plugins')()
mainBowerFiles = require 'main-bower-files'
paths = require './paths'

###
# Build Tasks
# Builds from public/ into dist/ while minifying and such
###

gulp.task 'minJS', ['coffee'], ->
  gulp.src "#{paths.publicDirJS}/app.js"
    .pipe plgn.ngAnnotate()
    .pipe plgn.uglify()
    .pipe gulp.dest "#{paths.distDir}/js/"

gulp.task 'minHTML', ['jade'], ->
  gulp.src "#{paths.publicDir}/**/*.html"
    .pipe plgn.htmlmin
      removeComments: true
      removeCDATASectionsFromCDATA: true
      collapseWhitespace: true
      collapseBooleanAttributes: true
      removeAttributeQuotes: true
      removeRedundantAttributes: true
      removeOptionalTags: true
      removeEmptyAttributes: true
    .pipe gulp.dest paths.distDir

gulp.task 'minCSS', ['stylus'], ->
  gulp.src "#{paths.publicDirCSS}/main.css"
    .pipe plgn.minifyCss()
    .pipe gulp.dest "#{paths.distDir}/css/"

gulp.task 'removeDist', ->
  gulp.src paths.distDir
    .pipe plgn.rimraf()

gulp.task 'copyBower', ->
  gulp.src mainBowerFiles(), base: './public/bower_components/'
    .pipe gulp.dest "#{paths.distDir}/bower_components/"

gulp.task 'images', ->
  gulp.src paths.images
    .pipe plgn.imagemin
      progressive: true
      optimizationLevel: 7
    .pipe gulp.dest "#{paths.distDir}/images/"

gulp.task 'serveDist', ->
  gulp.src paths.distDir
    .pipe plgn.webserver
      open: true

gulp.task 'minAll', ['minJS', 'minHTML', 'minCSS']

gulp.task 'build', ['removeDist'], ->
  gulp.start 'minAll', 'copyBower', 'images'
