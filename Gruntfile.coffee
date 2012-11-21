'use strict'
module.exports = (grunt) ->
  # Project configuration.
  grunt.initConfig
    cson:
      schemas:
        src: 'src'
        dest: 'lib'
        space: 2

  # Default task.
  grunt.loadTasks 'tasks'
  grunt.registerTask 'default', ['cson']
