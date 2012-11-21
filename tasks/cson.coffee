module.exports = (grunt) ->
  CSON = require 'cson'
  path = require 'path'
  fs = require 'fs'

  grunt.registerMultiTask 'cson', 'Compile CSON to JSON', ->
    src = @data.src
    dest = @data.dest
    space = @data.space

    filepaths = grunt.file.expandFiles path.join(src, '/**/*.cson')
    filepaths.forEach (filepath) ->
      result = CSON.parseFileSync filepath
      destpath = filepath.replace(src, dest).replace(/\.cson$/, '.json')
      fs.writeFileSync destpath, JSON.stringify(result, null, space), 'utf-8'
      grunt.log.writeln "Compiled '#{filepath}' -> '#{destpath}'"

    grunt.log.ok 'Compiling complete'
