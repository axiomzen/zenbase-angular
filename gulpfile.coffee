gulp       = require 'gulp'
jade       = require 'gulp-jade'
stylus     = require 'gulp-stylus'
coffee     = require 'gulp-coffee'
rimraf     = require 'gulp-rimraf'
watch      = require 'gulp-watch'
webserver  = require 'gulp-webserver'
plumber    = require 'gulp-plumber'
notify     = require 'gulp-notify'

paths =
  jade: 'src/**/*.jade'
  stylus: 'src/styles/*.styl'
  coffee: 'src/coffee/**/*.coffee'
  public: './public'

###
# Compilation Tasks
# Compiling Coffee/Jade/Stylus from src/ into public/
###

compileJade = (files) ->
  files
    .pipe plumber errorHandler: notify.onError("Jade error: <%= error.message %>")
    .pipe jade pretty: true
    .pipe gulp.dest paths.public

compileStylus = (files) ->
  files
    .pipe plumber errorHandler: notify.onError("Stylus error: <%= error.message %>")
    .pipe stylus()
    .pipe gulp.dest "#{paths.public}/css/"

compileCoffee = (files) ->
  files
    .pipe plumber errorHandler: notify.onError("Coffee error: <%= error.message %>")
    .pipe coffee()
    .pipe gulp.dest "#{paths.public}/js/"

# Remove ./public folder (except for bower_components)
gulp.task 'removePublic', ->
  gulp.src ["#{paths.public}/*", "!#{paths.public}/bower_components"], read: false
    .pipe rimraf()

# Get and compile all .coffee files in src/coffee/ folder
gulp.task 'coffee', ['removePublic'], ->
  compileCoffee gulp.src paths.coffee

# Get and compile all .jade files in src/ folder
gulp.task 'jade', ['removePublic'], ->
  compileJade gulp.src paths.jade

# Get and compile all .styl files in src/styles/ folder
gulp.task 'stylus', ['removePublic'], ->
  compileStylus gulp.src paths.stylus

# Compile all .jade, .stylus, .coffee files
gulp.task 'compile', ['removePublic', 'jade', 'stylus', 'coffee']

###
# Web server
# For local development
###

watchPath = (path, action) ->
  watch path, (files) ->
    action files

# Watch changes on .jade, .stylus and .coffee files
gulp.task 'watch', ['compile'], ->
  watchPath paths.jade, compileJade
  watchPath paths.stylus, compileStylus
  watchPath paths.coffee, compileCoffee

# Starts a local web server
gulp.task 'webserver', ['compile'], ->
  gulp.src 'public'
    .pipe webserver
      livereload: true
      open: true

# Default task
gulp.task 'default', ['compile', 'webserver', 'watch']
