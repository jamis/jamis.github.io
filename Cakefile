{print} = require 'sys'
{spawn} = require 'child_process'
fs      = require 'fs'

task 'tremaux', 'Build js sources for Tremaux demo', ->
  sources = [ '_src/mersenne.coffee', '_src/maze.coffee', '_src/rendered_maze.coffee', '_src/tremaux.coffee' ]
  coffee = spawn 'coffee', ['-c', '-j', 'tremaux', '-o', 'js', sources...]
  coffee.stdout.on 'data', (data) -> print data.toString()
  coffee.stderr.on 'data', (data) -> print data.toString()

  fs.open "js/tremaux-minified.js", "w", (err, fd) ->
    yui = spawn 'yuicompressor', ['js/tremaux.js']
    yui.stdout.on 'data', (data) -> fs.write(fd, data.toString())
    yui.stderr.on 'data', (data) -> print data.toString()
    yui.on 'exit', (code) -> fs.close(fd)

task 'dijkstra', 'Build js sources for Dijkstra demo', ->
  sources = [ '_src/mersenne.coffee', '_src/maze.coffee', '_src/rendered_maze.coffee', '_src/dijkstra.coffee' ]
  coffee = spawn 'coffee', ['-c', '-j', 'dijkstra', '-o', 'js', sources...]
  coffee.stdout.on 'data', (data) -> print data.toString()
  coffee.stderr.on 'data', (data) -> print data.toString()

  fs.open "js/dijkstra-minified.js", "w", (err, fd) ->
    yui = spawn 'yuicompressor', ['js/dijkstra.js']
    yui.stdout.on 'data', (data) -> fs.write(fd, data.toString())
    yui.stderr.on 'data', (data) -> print data.toString()
    yui.on 'exit', (code) -> fs.close(fd)

task 'tree-transform', 'Build js sources for tree-transform demo', ->
  sources = [ '_src/mersenne.coffee', '_src/maze.coffee', '_src/graph_transformation.coffee' ]
  coffee = spawn 'coffee', ['-c', '-j', 'tree-transform', '-o', 'js', sources...]
  coffee.stdout.on 'data', (data) -> print data.toString()
  coffee.stderr.on 'data', (data) -> print data.toString()

  fs.open "js/tree-transform-minified.js", "w", (err, fd) ->
    yui = spawn 'yuicompressor', ['js/tree-transform.js']
    yui.stdout.on 'data', (data) -> fs.write(fd, data.toString())
    yui.stderr.on 'data', (data) -> print data.toString()
    yui.on 'exit', (code) -> fs.close(fd)

task 'greedy', 'Build js sources for greedy demo', ->
  sources = [ '_src/mersenne.coffee', '_src/maze.coffee', '_src/rendered_maze.coffee', '_src/binary_heap.coffee', '_src/best_first_search.coffee', '_src/greedy.coffee' ]
  coffee = spawn 'coffee', ['-c', '-j', 'greedy', '-o', 'js', sources...]
  coffee.stdout.on 'data', (data) -> print data.toString()
  coffee.stderr.on 'data', (data) -> print data.toString()

  fs.open "js/greedy-minified.js", "w", (err, fd) ->
    yui = spawn 'yuicompressor', ['js/greedy.js']
    yui.stdout.on 'data', (data) -> fs.write(fd, data.toString())
    yui.stderr.on 'data', (data) -> print data.toString()
    yui.on 'exit', (code) -> fs.close(fd)

task 'astar', 'Build js sources for A* demo', ->
  sources = [ '_src/mersenne.coffee', '_src/maze.coffee', '_src/rendered_maze.coffee', '_src/binary_heap.coffee', '_src/best_first_search.coffee', '_src/a_star.coffee' ]
  coffee = spawn 'coffee', ['-c', '-j', 'astar', '-o', 'js', sources...]
  coffee.stdout.on 'data', (data) -> print data.toString()
  coffee.stderr.on 'data', (data) -> print data.toString()

  fs.open "js/astar-minified.js", "w", (err, fd) ->
    yui = spawn 'yuicompressor', ['js/astar.js']
    yui.stdout.on 'data', (data) -> fs.write(fd, data.toString())
    yui.stderr.on 'data', (data) -> print data.toString()
    yui.on 'exit', (code) -> fs.close(fd)

task 'searches', 'Build js sources for searches demo', ->
  sources = [ '_src/mersenne.coffee', '_src/maze.coffee', '_src/rendered_maze.coffee', '_src/binary_heap.coffee', '_src/parallel_searches.coffee' ]
  coffee = spawn 'coffee', ['-c', '-j', 'searches', '-o', 'js', sources...]
  coffee.stdout.on 'data', (data) -> print data.toString()
  coffee.stderr.on 'data', (data) -> print data.toString()

  fs.open "js/searches-minified.js", "w", (err, fd) ->
    yui = spawn 'yuicompressor', ['js/searches.js']
    yui.stdout.on 'data', (data) -> fs.write(fd, data.toString())
    yui.stderr.on 'data', (data) -> print data.toString()
    yui.on 'exit', (code) -> fs.close(fd)
