// gulpfile.js
var gulp = require('gulp');
var elm = require('gulp-elm');
var gutil = require('gulp-util');
var plumber = require('gulp-plumber');
var connect = require('gulp-connect');

// File paths
var paths = {
  dest: 'dist',
  elm: 'src/Main.elm',
  allelm: 'src/*.elm',
  taskelm: 'src/Tasks/*.elm',
  static: 'static/*.{js,css,html}',
};

// Init Elm
gulp.task('elm-init', elm.init);

// Compile Main.elm to JS
gulp.task('elm', ['elm-init'], function(){
    return gulp.src(paths.elm)
        .pipe(plumber())
        .pipe(elm.make('html'))
        .pipe(gulp.dest(paths.dest));
});

// Move static assets to dist
gulp.task('static', function() {
    return gulp.src(paths.static)
        .pipe(plumber())
        .pipe(gulp.dest(paths.dest));
});

// Watch for changes and compile
gulp.task('watch', function() {
    gulp.watch(paths.allelm, ['elm']);
    gulp.watch(paths.taskelm, ['elm']);
    gulp.watch(paths.static, ['static']);
});

// Local server
gulp.task('connect', function() {
    connect.server({
        root: 'dist',
        port: 8000
    });
});

// Main gulp tasks
gulp.task('build', ['elm', 'static']);
gulp.task('default', ['connect', 'build', 'watch']);
