'use strict';

var gulp        = require('gulp');
var browserify  = require('browserify');
var watchify    = require('watchify');
var streamify   = require('gulp-streamify');
var source      = require('vinyl-source-stream');
var uglify      = require('gulp-uglify');
var envify      = require('envify');

var bundler = function(watch) {
  var bundler =  browserify(
    require.resolve('../src/index.js'),
    { debug: true, entry: true }
  );
  return bundler.bundle();
};

var Task = function() {
    return bundler(false)
      .pipe(source('bundle.js'))
      .pipe(gulp.dest('./build/'));
};

var Build = function() {
  return bundler(false)
    .pipe(source('bundle.min.js'))
    .pipe(streamify(uglify()))
    .pipe(gulp.dest('./build/'));
};

var Watch = function() {
  watchify.args.debug = true;
  var bundler = watchify(browserify('./src/index.js', watchify.args));
  bundler.require(require.resolve('../src/index.js', {entry: true}));
  bundler.on('update', rebundle);
  function rebundle() {
    return bundler.bundle()
      .on('error', function(err) {
        gutil.log(err.toString());
        this.emit();
      })
      .pipe(source('bundle.js'))
      .pipe(gulp.dest('./build'));
  }
  return rebundle();
};

module.exports = {
  Task: Task,
  Build: Build,
  Watch: Watch
};
