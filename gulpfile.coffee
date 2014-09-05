gulp       = require 'gulp'
jade       = require 'gulp-jade'
stylus     = require 'gulp-stylus'
coffee     = require 'gulp-coffee'
gutil      = require 'gulp-util'
rimraf     = require 'rimraf'
watch      = require 'gulp-watch'
webserver  = require 'gulp-webserver'

paths =
  jade: 'src/**/*.jade'
  stylus: 'src/styles/*.styl'
  coffee: 'src/coffee/**/*.coffee'

###
# Compilation Tasks
###

translateJade = (files) ->
  files
    .pipe jade pretty: true
    .pipe gulp.dest './public/'

translateStylus = (files) ->
  files
    .pipe stylus()
    .pipe gulp.dest './public/css/'

translateCoffee = (files) ->
  files
    .pipe coffee().on('error', gutil.log)
    .pipe gulp.dest './public/js/'

watchPath = (path, action) ->
  watch path, (files) ->
    action files

gulp.task 'jade', ->
  translateJade gulp.src paths.jade

# Get and render all .styl files in src/styles/ folder
gulp.task 'stylus', ->
  translateStylus gulp.src paths.stylus

gulp.task 'coffee', ->
  translateCoffee gulp.src paths.coffee

gulp.task 'removePublic', (cb) ->
  rimraf './public/', cb

gulp.task 'watch', ->
  watchPath paths.jade, translateJade
  watchPath paths.stylus, translateStylus
  watchPath paths.coffee, translateCoffee

gulp.task 'compile', ['jade', 'stylus', 'coffee']


###
# Web server
###

gulp.task 'webserver', ->
  gulp.src 'public'
    .pipe webserver
      livereload: true
      open: true
