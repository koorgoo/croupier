module.exports = function(grunt) {
  grunt.initConfig({
    requirejs: {
      dev: {
        options: {
          optimize: 'none',
          mainConfigFile: 'app/scripts/config.js',
          out: 'croupier/static/croupier/js/app.js',
        }
      },
      prod: {
        options: {
          optimize: 'uglify',
          mainConfigFile: 'app/scripts/config.js',
          out: 'croupier/static/croupier/js/app.js',
        }
      }
    },
    less: {
      dev: {
        options: {
          paths: ['app/styles'],
        },
        files: { 
          'croupier/static/croupier/css/app.css': 'app/styles/main.less' 
        }
      },
      prod: {
        options: {
          paths: ['app/styles'],
          cleancss: true
        },
        files: { 
          'croupier/static/croupier/css/app.css': 'app/styles/main.less' 
        }
      }
    },
    watch: {
      scripts: {
        files: [
          'app/scripts/**/*.js', 
          'app/scripts/**/*.coffee',
          'app/scripts/**/*.html'
        ],
        tasks: ['requirejs:dev'],
        options: { interrupt: true }
      },
      styles: {
        files: [
          'app/styles/**/*.css',
          'app/styles/**/*.less'
        ],
        tasks: ['less:dev'],
        options: { interrupt: true }
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-requirejs');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerTask('default', ['requirejs:dev', 'less:dev']);
  grunt.registerTask('build', ['requirejs:prod', 'less:prod']);
};
