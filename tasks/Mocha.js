'use strict';

var gulp  = require('gulp');
var mocha = require('gulp-mocha');
var gutil = require('gulp-util');

require('coffee-script/register');

var paths = {
  tests: {
    unit: './tests/unit/**/*.coffee',
    integration: './tests/integration/**/*.coffee'
  },
  src: './src/**/*.js'
};

var Task = function() {
  gulp.src([
    paths.tests.unit,
    paths.tests.integration
  ], { read: false })
    .pipe(mocha({
      reporter: 'nyan',
      compiler: 'coffee:coffee-script'
    }))
    .on('error', function(err) {
      gutil.log(err.toString());
      this.emit();
    });
};

var Watch = function() {
  gulp.watch([
    paths.tests.unit,
    paths.tests.integration,
    paths.src
  ], ['mocha']);
};

module.exports = {
  Task: Task,
  Watch: Watch
};
