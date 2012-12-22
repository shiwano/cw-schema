path = require 'path'
fs = require 'fs'

module.exports = (grunt) ->
  grunt.initConfig
    watch:
      files: ['src/**/*.yml']
      tasks: 'yaml'

    yaml:
      schemas:
        options:
          ignored: /^_/
          space: 0
          constructors:
            '!include': (node, yaml) ->
              filepath = path.join 'src', node.value
              data = fs.readFileSync filepath, 'utf-8'
              yaml.load data
        src: 'src/**/*.yml'
        dest: 'lib'

  # Default task.
  grunt.loadTasks 'tasks'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-yaml'
  grunt.registerTask 'default', ['yaml']
