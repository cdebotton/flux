'use strict';

var gulp        = require('gulp');
var Mocha       = require('./tasks/Mocha');
var Browserify  = require('./tasks/Browserify');

gulp.task('mocha', Mocha.Task);
gulp.task('mocha:watch', Mocha.Watch);
gulp.task('browserify', Browserify.Task);
gulp.task('browserify:watch', Browserify.Watch);
gulp.task('browserify:build', Browserify.Build);

gulp.task('default', ['browserify', 'browserify:watch']);
gulp.task('build', ['mocha', 'browserify:build']);
gulp.task('test', ['mocha']);
gulp.task('test:watch', ['mocha', 'mocha:watch']);
