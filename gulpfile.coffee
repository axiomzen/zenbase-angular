gulp       = require 'gulp'
jade       = require 'gulp-jade'
stylus     = require 'gulp-stylus'
coffee     = require 'gulp-coffee'
gutil      = require 'gulp-util'
rimraf     = require 'rimraf'
webserver  = require 'gulp-webserver'

###
# Compilation Tasks
###

gulp.task 'jade', ->
  gulp.src ['src/index.jade', 'src/**/*.jade']
    .pipe jade pretty: true
    .pipe gulp.dest './public/'

# Get and render all .styl files in src/styles/ folder
gulp.task 'stylus', ->
  gulp.src 'src/styles/*.styl'
    .pipe stylus()
    .pipe gulp.dest './public/css/'

gulp.task 'coffee', ->
  gulp.src ['src/coffee/**/*.coffee']
    .pipe coffee().on('error', gutil.log)
    .pipe gulp.dest './public/js/'

gulp.task 'removePublic', (cb) ->
  rimraf './public/', cb

gulp.task 'compile', ['jade', 'stylus', 'coffee']


###
# Web server
###

gulp.task 'webserver', ->
  gulp.src 'public'
    .pipe webserver
      livereload: true
      open: true
