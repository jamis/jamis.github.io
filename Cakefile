{print} = require 'sys'
{spawn} = require 'child_process'
fs      = require 'fs'

task 'tremaux', 'Build js sources for Tremaux demo', ->
  sources = [ '_src/mersenne.coffee', '_src/maze.coffee', '_src/tremaux.coffee' ]
  coffee = spawn 'coffee', ['-c', '-j', 'tremaux', '-o', 'js', sources...]
  coffee.stdout.on 'data', (data) -> print data.toString()
  coffee.stderr.on 'data', (data) -> print data.toString()

  fs.open "js/tremaux-minified.js", "w", (err, fd) ->
    yui = spawn 'yuicompressor', ['js/tremaux.js']
    yui.stdout.on 'data', (data) -> fs.write(fd, data.toString())
    yui.stderr.on 'data', (data) -> print data.toString()
    yui.on 'exit', (code) -> fs.close(fd)
