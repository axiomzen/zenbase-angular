gulp       = require 'gulp'
jade       = require 'gulp-jade'
stylus     = require 'gulp-stylus'

gulp.task 'jade', ->
  gulp.src ['src/index.jade', 'src/**/*.jade']
    .pipe jade pretty: true
    .pipe gulp.dest './dist/'

# Get and render all .styl files in src/styles/ folder
gulp.task 'stylus', ->
  gulp.src 'src/styles/*.styl'
    .pipe stylus()
    .pipe gulp.dest './public/css/'
