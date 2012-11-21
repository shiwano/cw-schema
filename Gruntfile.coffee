'use strict'
module.exports = (grunt) ->
  # Project configuration.
  grunt.initConfig
    coffeeToJSON:
      gruntfile:
        files: 'src'

  # Default task.
  #grunt.registerTask 'default', ['jshint', 'nodeunit']
