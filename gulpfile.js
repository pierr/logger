var gulp = require('gulp');
var concat = require('gulp-concat');
/**
 * Build all the jade templates.
 * @return {function}
 */
gulp.task('templates', function() {
  var jade = require('gulp-jade');
  var defineModule = require('gulp-define-module');
  gulp.src('./lib/templates/*.jade')
    .pipe(jade({  client: true}))
    .pipe(defineModule('commonjs'))
    .pipe(gulp.dest('./lib/templates/'));
});

gulp.task('browserify' ,function() {
  var browserify = require('browserify');
  var source = require('vinyl-source-stream');
  return browserify(({entries: ['./lib/index.coffee'], extensions: ['.coffee']}))
    .bundle()
    //Pass desired output filename to vinyl-source-stream
    .pipe(source('loggerz.js'))
    // Start piping stream to tasks!
    .pipe(gulp.dest('./dist/'))
    .pipe(gulp.dest('./example/'));
});

gulp.task('style', function(){
  var stylus = require('gulp-stylus');
  gulp.src('./lib/styles/*.styl')
    .pipe(stylus())
    .pipe(concat('hub.css'))
    .pipe(gulp.dest('./dist/'))
    .pipe(gulp.dest('./example/'));
});
//
var browserSync = require('browser-sync');
var reload = browserSync.reload;
// Watch Files For Changes & Reload
gulp.task('serve', ['browserify'], function () {
  browserSync({
    notify: false,
    // Run as an https by uncommenting 'https: true'
    // Note: this uses an unsigned certificate which on first access
    //       will present a certificate warning in the browser.
    // https: true,
    server: {
      baseDir: ['example']
    }
  });

  gulp.watch(['lib/**/*.js'],['browserify',reload]);
  //gulp.watch(['lib/templates/*.jade'], ['templates', reload]);
  //gulp.watch(['lib/styles/*.{styl,css}'], ['style', reload]);
  //gulp.watch(['lib/*.json'], ['browserify',reload]);
  //gulp.watch(['app/scripts/**/*.js'], jshint);
  //gulp.watch(['app/images/**/*'], reload);
});

// The default task (called when you run `gulp` from cli)
gulp.task('default', ['browserify'/*, 'style'*/]);