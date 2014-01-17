path = require 'path'
fs = require 'fs'
_ = require 'lodash'

readPartialYAML = (partialpath, yamlLoader) ->
  [filename, propName] = partialpath.split('#')
  filepath = path.join 'src', filename
  data = fs.readFileSync filepath, 'utf-8'
  result = yamlLoader data
  result = result[propName] if propName and result[propName]
  result

module.exports = (grunt) ->
  grunt.initConfig
    clean:
      yaml: ['lib']

    watch:
      files: ['src/**/*.yml']
      tasks: 'default'

    yaml:
      schemas:
        options:
          ignored: /^_/
          space: 0
          customTypes:
            '!include scalar': (value, yamlLoader) ->
              readPartialYAML value, yamlLoader
            '!extend mapping': (value, yamlLoader) ->
              baseObject = readPartialYAML value.base, yamlLoader
              _.extend baseObject, value.partial
        files: [
          {expand: true, cwd: 'src/', src: ['**/*.yml'], dest: 'lib/'}
        ]

  # Default task.
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-yaml'
  grunt.registerTask 'default', ['clean', 'yaml']
