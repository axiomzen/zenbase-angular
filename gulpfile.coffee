gulp       = require 'gulp'
jade       = require 'gulp-jade'
stylus     = require 'gulp-stylus'
coffee     = require 'gulp-coffee'

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
    .pipe coffee()
    .pipe gulp.dest './public/js/'
