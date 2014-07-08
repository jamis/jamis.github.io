class window.BestFirstSearch extends RenderedMaze

  PENDING: 0x1000
  VISITED: 0x2000

  constructor: (id, width, height, options) ->
    options ?= {}

    super id, width, height, {seed: options.seed}, (maze) =>
      @maze.thin options.thin ? 25

      if options.longestPath?
        [@startX, @startY, @endX, @endY, @shortest] = @maze.findLongestPath()

      else
        @startX = @maze.rand.nextInteger(width//2)
        @startY = @maze.rand.nextInteger(height//2)
        @endX   = width//2 + @maze.rand.nextInteger(width//2)
        @endY   = height//2 + @maze.rand.nextInteger(height//2)

        [_,_,_,_, @shortest] = @maze.findPathBetween(@startX, @startY, @endX, @endY)

    @resetState()

  nodeComparison: (a,b) ->
    # subclasses return true if a should sort higher than b
    # a[0] = x
    # a[1] = y
    # a[2] = parent node
    # a[3] = current path length
    true

  resetState: ->
    for y in [0..@maze.height-1]
      for x in [0..@maze.width-1]
        @maze.unmark(x, y, @VISITED|@PENDING)

    @heap = new BinaryHeap((a,b) => @nodeComparison(a,b))
    @tail = [@startX, @startY, null, 0]
    @heap.insert @tail
    @maze.mark(@startX, @startY, @PENDING)

    @finished = false

  stop: ->
    if @timer?
      window.clearInterval(@timer)
      delete @timer

  reset: ->
    @stop()
    @resetState()
    @rerender()

  run: (delay) ->
    unless @timer?
      @timer = window.setInterval((=> @runStep()), delay ? 50)

  runStep: ->
    unless @update()
      window.clearInterval(@timer)
      delete @timer

  update: ->
    return false if @finished || @heap.isEmpty()

    { dx, dy, opposite, directions } = @maze.utilities()
    [x, y, parent, length] = @tail = @heap.delete()
    @maze.mark(x, y, @VISITED)

    if x == @endX && y == @endY
      @finished = true
    else
      @maze.mark(x, y)

      for dir in directions
        if @maze.isMarked(dir, x, y)
          [nx, ny] = [x + dx(dir), y + dy(dir)]
          #if !parent? || parent[0] != nx || parent[1] != ny
          if !@maze.isMarked(@PENDING, nx, ny)
            @heap.insert [nx, ny, @tail, length+1]
            @maze.mark(nx, ny, @PENDING)

    @rerender()
    true

  renderBackground: (ctx) ->
    super ctx

    for y in [0..@maze.height-1]
      for x in [0..@maze.width-1]
        continue unless @maze.isMarked(@VISITED, x, y)

        ctx.fillStyle = "rgb(200,200,200)"

        x1 = Math.round(x * @dx)
        y1 = Math.round(y * @dy)
        ctx.fillRect(x1, y1, Math.ceil(@dx), Math.ceil(@dy))

    for [x, y] in @shortest
        ctx.fillStyle = "rgb(255,255,128)"

        x1 = Math.round(x * @dx)
        y1 = Math.round(y * @dy)
        ctx.fillRect(x1, y1, Math.ceil(@dx), Math.ceil(@dy))

    node = @tail
    while node
      [x, y, node] = node
      ctx.fillStyle = "rgb(128,255,128)"
      x1 = Math.round(x * @dx)
      y1 = Math.round(y * @dy)
      ctx.fillRect(x1, y1, Math.ceil(@dx), Math.ceil(@dy))
