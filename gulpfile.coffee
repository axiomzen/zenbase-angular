gulp       = require 'gulp'
jade       = require 'gulp-jade'

gulp.task 'jade', ->
  gulp.src ['src/index.jade', 'src/**/*.jade']
    .pipe jade pretty: true
    .pipe gulp.dest './public/'
