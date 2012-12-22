path = require 'path'
fs = require 'fs'
_ = require 'underscore'

readPartialYAML = (partialpath, yaml) ->
  [filename, propName] = partialpath.split('#')
  filepath = path.join 'src', filename
  data = fs.readFileSync filepath, 'utf-8'
  result = yaml.load data
  result = result[propName] if propName and result[propName]
  result

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
              readPartialYAML node.value, yaml
            '!extend': (node, yaml) ->
              [partialpath, srcObject] = yaml.load node.value
              destObject = readPartialYAML partialpath, yaml
              _.extend destObject, srcObject
        src: 'src/**/*.yml'
        dest: 'lib'

  # Default task.
  grunt.loadTasks 'tasks'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-yaml'
  grunt.registerTask 'default', ['clean', 'yaml']
