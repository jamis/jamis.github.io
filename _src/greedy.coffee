class window.Greedy extends RenderedMaze

  VISITED: 0x1000

  constructor: (id, width, height) ->
    super id, width, height, (maze) =>
      @maze.thin 35
      [@startX, @startY, @endX, @endY, @shortest] = @maze.findLongestPath()

    @resetState()

  resetState: ->
    for y in [0..@maze.height-1]
      for x in [0..@maze.width-1]
        @maze.unmark(x, y, @VISITED)

    nodeComparison = (a, b) =>
      adist = Math.abs(a[0] - @endX) + Math.abs(a[1] - @endY)
      bdist = Math.abs(b[0] - @endX) + Math.abs(b[1] - @endY)
      adist <= bdist

    @heap = new BinaryHeap(nodeComparison)
    @tail = [@startX, @startY, null]
    @heap.insert @tail
    @maze.mark(@startX, @startY, @VISITED)

    @finished = false

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
      @timer = window.setInterval((=> @runStep()), delay ? 50)

  runStep: ->
    unless @update()
      window.clearInterval(@timer)
      delete @timer

  update: ->
    return false if @finished || @heap.isEmpty()

    deadEnd = true

    while deadEnd
      { dx, dy, opposite, directions } = @maze.utilities()
      [x, y, parent] = @tail = @heap.peek()

      if x == @endX && y == @endY
        @finished = true
        break

      @maze.mark(x, y)

      for dir in directions
        if @maze.isMarked(dir, x, y)
          [nx, ny] = [x + dx(dir), y + dy(dir)]
          if !@maze.isMarked(@VISITED, nx, ny)
            @heap.insert [nx, ny, @tail]
            @maze.mark(nx, ny, @VISITED)
            deadEnd = false

      if deadEnd
        @maze.unmark(x, y)
        @heap.delete()

    @render()
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

window.generateGreedy = (id, size) ->
  canvas = document.getElementById id
  canvas.greedy?.stop()

  greedy = new Greedy id, size, size
  greedy.render()

  canvas.greedy = greedy
  return

window.resetGreedy = (id) ->
  canvas = document.getElementById id
  canvas.greedy?.reset()
  return

window.updateGreedy = (id) ->
  canvas = document.getElementById id
  canvas.greedy?.update()
  return

window.runGreedy = (id, delay) ->
  canvas = document.getElementById id
  canvas.greedy?.run(delay)
  return
