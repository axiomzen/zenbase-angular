gulp = require 'gulp'
plgn = require('gulp-load-plugins')()
wiredep = require('wiredep').stream
paths = require './paths'

###
# Compilation Tasks
# Compiling Coffee/Jade/Stylus from src/ into public/
###

# Get and compile all .coffee files in src/coffee/ folder
gulp.task 'coffee', ['removeJS'], ->
  gulp.src paths.coffee
    .pipe plgn.plumber
      errorHandler: plgn.notify.onError "Coffee error: <%= error.message %>"
    .pipe plgn.sourcemaps.init()
    .pipe plgn.coffee()
    .pipe plgn.sourcemaps.write()
    .pipe plgn.concat 'app.js'
    .pipe gulp.dest "#{paths.public}/js/"

# Get and compile all .jade files in src/ folder
gulp.task 'jade', ['removeHTML'], ->
  gulp.src paths.jade
    .pipe plgn.plumber
      errorHandler: plgn.notify.onError "Jade error: <%= error.message %>"
    .pipe wiredep ignorePath: paths.public
    .pipe plgn.jade pretty: true
    .pipe gulp.dest "#{paths.public}"

# Get and compile all .styl files in src/styles/ folder
gulp.task 'stylus', ['removeCSS'], ->
  gulp.src paths.stylusMain
    .pipe plgn.plumber
      errorHandler: plgn.notify.onError "Stylus error: <%= error.message %>"
    .pipe plgn.stylus()
    .pipe gulp.dest "#{paths.public}/css/"

gulp.task 'removeJS', ->
  gulp.src "#{paths.public}/js/"
    .pipe plgn.rimraf()

gulp.task 'removeHTML', ->
  gulp.src ["#{paths.public}/index.html", "#{paths.public}/views/"]
    .pipe plgn.rimraf()

gulp.task 'removeCSS', ->
  gulp.src "#{paths.public}/css/"
    .pipe plgn.rimraf()

# Remove all compiled files from public folder (ignores bower_components)
gulp.task 'removePublic', ['removeJS', 'removeHTML', 'removeCSS']

# Compile all .jade, .stylus, .coffee files
gulp.task 'compile', ['removePublic', 'jade', 'coffee', 'stylus']
