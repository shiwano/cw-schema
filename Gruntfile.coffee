path = require 'path'
fs = require 'fs'

module.exports = (grunt) ->
  grunt.initConfig
    clean:
      tests: ['lib']

    watch:
      files: ['src/**/*.yml']
      tasks: ['clean', 'yaml']

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
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-yaml'
  grunt.registerTask 'default', ['clean', 'yaml']
