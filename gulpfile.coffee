gulp = require 'gulp'
plgn = require('gulp-load-plugins')()

paths =
  coffee: 'src/coffee/**/*.coffee'
  jade: 'src/**/*.jade'
  stylus: 'src/styles/**/*.styl'
  stylusMain: 'src/styles/main.styl'
  public: './public'

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

###
# Web server
# For local development
###

# Watch changes on .jade, .stylus and .coffee files
gulp.task 'watch', ['compile'], ->
  gulp.watch paths.jade, ['jade']
  gulp.watch paths.stylus, ['stylus']
  gulp.watch paths.coffee, ['coffee']

# Starts a local web server
gulp.task 'webserver', ['compile'], ->
  gulp.src 'public'
    .pipe plgn.webserver
      livereload: true
      open: true

# Default task
gulp.task 'default', ['compile', 'webserver', 'watch']
