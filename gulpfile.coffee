gulp       = require 'gulp'
jade       = require 'gulp-jade'
coffee     = require 'gulp-coffee'
gutil      = require 'gulp-util'

gulp.task 'jade', ->
  gulp.src ['src/index.jade', 'src/**/*.jade']
    .pipe jade pretty: true
    .pipe gulp.dest './public/'

gulp.task 'coffee', ->
  gulp.src ['src/coffee/**/*.coffee']
    .pipe coffee().on('error', gutil.log)
    .pipe gulp.dest './public/js/'
