'use strict'

module.exports = (grunt) ->
  (require 'time-grunt') grunt
  (require 'load-grunt-tasks') grunt

  config =
    src: 'src'
    test: 'test'
    dist: 'dist'

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    config: config

    watch:
      coffee:
        files: ['<%= config.src %>/{,*/}*.coffee']
        tasks: ['newer:coffeelint:all', 'coffee:dist']
      jsTest:
        files: [
          '<%= config.dist %>/<%= pkg.name %>.js'
          '<%= config.test %>/{spec,mock}/{,*/}*.coffee'
        ]
        tasks: ['karma']
      gruntfile:
        files: ['Gruntfile.coffee']
        tasks: ['coffeelint:gruntfile']

    coffee:
      options:
        bare: true

      dist:
        files:
          '<%= config.dist %>/<%= pkg.name %>.js': [
            '<%= config.src %>/{,*/}*.coffee'
          ]

    # Make sure code styles are up to par and there are no obvious mistakes
    coffeelint:
      all: ['<%= config.src %>/{,*/}*.coffee']
      test: ['<%= config.test %>/{spec,mock}/{,*/}*.coffee']
      gruntfile: ['Gruntfile.coffee']

    # Minify JavaScript code
    uglify:
      dist:
        files:
          '<%= config.dist %>/<%= pkg.name %>.min.js': [
            '<%= config.dist %>/<%= pkg.name %>.js'
          ]

    # Empties folders to start fresh
    clean:
      dist:
        files: [
          dot: true
          src: [
            '<%= config.dist %>/{,*/}*'
            '!<%= config.dist %>/.git*'
          ]
        ]

    # Run some tasks in parallel to speed up the build process
    concurrent:
      test: [
        'coffee:dist'
      ]
      dist: [
        'coffee:dist'
      ]

    # Test settings
    karma:
      unit:
        configFile: '<%= config.test %>/karma.conf.js'
        singleRun: true


  grunt.registerTask 'test', [
    'clean:dist'
    'concurrent:test'
    'karma'
  ]

  grunt.registerTask 'build', [
    'clean:dist'
    'concurrent:dist'
    'uglify'
  ]

  grunt.registerTask 'default', [
    'newer:coffeelint'
    'build'
    'test'
    'watch'
  ]
