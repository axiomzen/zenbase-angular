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
    .pipe plgn.rev()
    .pipe gulp.dest "#{paths.distDir}/js/"
    .pipe plgn.rev.manifest()
    .pipe gulp.dest "#{paths.revDir}/js"

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
    .pipe plgn.rev()
    .pipe gulp.dest "#{paths.distDir}/css/"
    .pipe plgn.rev.manifest()
    .pipe gulp.dest "#{paths.revDir}/css"

gulp.task 'revision', ['minJS', 'minCSS', 'minHTML'], ->
  gulp.src ["#{paths.revDir}/**/*.json",
      "#{paths.distDir}/**/*.html"]
    .pipe plgn.revCollector()
    .pipe gulp.dest "#{paths.distDir}"

gulp.task 'removeDist', ->
  gulp.src paths.distDir, read: false
    .pipe plgn.rimraf()

gulp.task 'removeRev', ->
  gulp.src paths.revDir
    .pipe plgn.rimraf()

gulp.task 'copyBower', ->
  gulp.src mainBowerFiles(), base: './public/bower_components/'
    .pipe plgn.if '*.js', plgn.uglify()
    .pipe plgn.if '*.css', plgn.minifyCss()
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

gulp.task 'minAll', ['minJS', 'minHTML', 'minCSS', 'revision']

gulp.task 'build', ['removeDist', 'removeRev'], ->
  gulp.start 'minAll', 'copyBower', 'images'
