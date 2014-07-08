class window.ParallelSearches extends RenderedMaze

  class SearchAlgorithm
    PENDING: 0x1000
    VISITED: 0x2000

    constructor: (@maze, @startX, @startY, @endX, @endY) ->
      @resetState()

    resetState: ->
      @grid = ((0 for x in [1..@maze.width]) for y in [1..@maze.height])
      @heap = new BinaryHeap((a,b) => @compareNodes(a,b))
      @tail = [@startX, @startY, null, 0]
      @heap.insert @tail
      @finished = false

    isVisited: (x,y) ->
      (@grid[y][x] & @VISITED) == @VISITED

    compareNodes: (a,b) ->
      # return true if a is more desirable than b

    step: ->
      return false if @finished || @heap.isEmpty()

      { dx, dy, opposite, directions } = @maze.utilities()
      [x, y, parent, length] = @tail = @heap.delete()
      @grid[y][x] |= @VISITED

      if x == @endX && y == @endY
        @finished = new Date().getTime()
      else
        for dir in directions
          if @maze.isMarked(dir, x, y)
            [nx, ny] = [x + dx(dir), y + dy(dir)]
            #if !parent? || parent[0] != nx || parent[1] != ny
            if (@grid[ny][nx] & @PENDING) == 0
              @heap.insert [nx, ny, @tail, length+1]
              @grid[ny][nx] |= @PENDING

    elapsed: ->
      if @started?
        endDate = @finished || new Date().getTime()
        endDate - @started
      else
        0

  class Dijkstra extends SearchAlgorithm
    compareNodes: (a,b) -> a[3] <= b[3]

  class Greedy extends SearchAlgorithm
    compareNodes: (a,b) ->
      adist = Math.abs(a[0] - @endX) + Math.abs(a[1] - @endY)
      bdist = Math.abs(b[0] - @endX) + Math.abs(b[1] - @endY)
      adist <= bdist

  class Astar extends SearchAlgorithm
    compareNodes: (a,b) ->
      adist = Math.abs(a[0] - @endX) + Math.abs(a[1] - @endY) + a[3]
      bdist = Math.abs(b[0] - @endX) + Math.abs(b[1] - @endY) + b[3]
      adist <= bdist

  constructor: (id, width, height, seed) ->
    super id, width, height, {seed}, (maze) =>
      @maze.thin 25
      #[@startX, @startY, @endX, @endY, @shortest] = @maze.findLongestPath()

      @startX = @maze.rand.nextInteger(width//2)
      @startY = @maze.rand.nextInteger(height//2)
      @endX   = width//2 + @maze.rand.nextInteger(width//2)
      @endY   = height//2 + @maze.rand.nextInteger(height//2)

      [_,_,_,_, @shortest] = @maze.findPathBetween(@startX, @startY, @endX, @endY)

    @resetState()

  resetState: ->
    @dijkstra = new Dijkstra(@maze, @startX, @startY, @endX, @endY)
    @greedy   = new Greedy(@maze, @startX, @startY, @endX, @endY)
    @astar    = new Astar(@maze, @startX, @startY, @endX, @endY)

  stop: ->
    if @timer?
      window.clearInterval(@timer)
      delete @timer

  reset: ->
    @stop()
    @resetState()
    @render()

  run: (delay) ->
    unless @timer?
      @dijkstra.started = @greedy.started = @astar.started = new Date().getTime()
      @timer = window.setInterval((=> @runStep()), delay ? 50)

  runStep: ->
    unless @update()
      window.clearInterval(@timer)
      delete @timer

  update: ->
    alive = false
    alive = @dijkstra.step() || alive
    alive = @greedy.step() || alive
    alive = @astar.step() || alive

    @renderAll() if alive
    alive

  renderAll: ->
    @clear()

    width = @canvas.width // 2
    height = @canvas.height // 2

    algos = [
      { name: "Dijkstra", impl: @dijkstra, ox: 0, oy: 0, w: width, h: height, bg: "rgb(255,200,200)", path: "rgb(200,50,50)" },
      { name: "Greedy", impl: @greedy, ox: width, oy: 0, w: width, h: height, bg: "rgb(200,255,200)", path: "rgb(50,200,50)" },
      { name: "A*", impl: @astar, ox: 0, oy: height, w: width, h: height, bg: "rgb(200,200,255)", path: "rgb(50,50,200)" }
    ]

    ctx = @canvas.getContext "2d"

    for algorithm, i in algos
      @renderInBounds(algorithm.ox, algorithm.oy, algorithm.w, algorithm.h, algorithm)
      ctx.beginPath()
      ctx.fillStyle = algorithm.path
      ctx.font = "bold 20px sans-serif"
      ctx.fillText "#{algorithm.name}: #{algorithm.impl.tail[3]}", width + 25, height + 36 + i*56

      elapsed = algorithm.impl.elapsed()
      minutes = elapsed // 60000
      seconds = (elapsed % 60000) // 1000
      millis  = elapsed % 1000

      minutes = "0#{minutes}" if minutes.toString().length < 2
      seconds = "0#{seconds}" if seconds.toString().length < 2
      millis = "0#{millis}"   while millis.toString().length < 3

      ctx.font = "20px sans-serif"
      ctx.fillText "#{minutes}:#{seconds}.#{millis}", width + 60, height + 36 + i*56 + 28

  renderBackground: (ctx, algo) ->
    super ctx

    ctx.fillStyle = algo.bg
    for y in [0..@maze.height-1]
      for x in [0..@maze.width-1]
        continue unless algo.impl.isVisited(x, y)

        x1 = @displayedOriginX + Math.round(x * @dx)
        y1 = @displayedOriginY + Math.round(y * @dy)
        ctx.fillRect(x1, y1, Math.ceil(@dx), Math.ceil(@dy))

    node = algo.impl.tail
    ctx.fillStyle = algo.path
    while node
      [x, y, node, distance] = node
      x1 = @displayedOriginX + Math.round(x * @dx)
      y1 = @displayedOriginY + Math.round(y * @dy)
      ctx.fillRect(x1, y1, Math.ceil(@dx), Math.ceil(@dy))

window.generateSearches = (id, size, seed) ->
  canvas = document.getElementById id
  canvas.searches?.stop()

  searches = new ParallelSearches id, size, size, seed
  searches.renderAll()

  canvas.searches = searches
  return

window.resetSearches = (id) ->
  canvas = document.getElementById id
  canvas.searches?.reset()
  return

window.updateSearches = (id) ->
  canvas = document.getElementById id
  canvas.searches?.update()
  return

window.runSearches = (id, delay) ->
  canvas = document.getElementById id
  canvas.searches?.run(delay)
  return
