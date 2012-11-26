'use strict'
module.exports = (grunt) ->
  # Project configuration.
  grunt.initConfig
    watch:
      files: ['src/**/*.cson']
      tasks: 'cson'

    cson:
      schemas:
        src: 'src'
        dest: 'lib'
        # space: 2

  # Default task.
  grunt.loadTasks 'tasks'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.registerTask 'default', ['cson']
