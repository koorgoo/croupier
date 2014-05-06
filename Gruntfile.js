module.exports = function(grunt) {
  grunt.initConfig({
    requirejs: {
      compile: {
        options: {
          optimize: 'none',
          mainConfigFile: 'app/scripts/config.js',
          out: 'croupier/static/croupier/app.js',
        }
      }
    },
    uglify: {
      app: {
        files: {
          'croupier/static/croupier/app.js': ['croupier/static/croupier/app.js']
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
        tasks: ['requirejs'],
        options: {
          interrupt: true,
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-requirejs');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerTask('default', ['requirejs']);
  grunt.registerTask('build', ['requirejs', 'uglify']);
};
