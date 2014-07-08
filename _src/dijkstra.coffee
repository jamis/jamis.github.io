class window.Dijkstra extends RenderedMaze

  constructor: (id, width, height, seed) ->
    super id, width, height, {seed}, (maze) =>
      @maze.thin 50
      [@startX, @startY] = [width // 2, height // 2]
      [distances, @longestPath, [x, y]] = @maze.findDistances(@startX, @startY)

    @resetState()

  resetState: ->
    @frontier = [[@startX, @startY]]
    @steps = ((undefined for x in [1..@maze.width]) for y in [1..@maze.height])
    @steps[@startY][@startX] = 0

  reset: ->
    if @timer?
      window.clearInterval(@timer)
      delete @timer

    @resetState()
    @rerender()

  run: (delay) ->
    unless @timer?
      @timer = window.setInterval((=> @runStep()), delay ? 100)

  runStep: ->
    unless @update()
      window.clearInterval(@timer)
      delete @timer

  update: ->
    return false if @frontier.length is 0

    { dx, dy, opposite, directions } = @maze.utilities()

    newFrontier = []
    for [x, y] in @frontier
      distance = @steps[y][x]
      for dir in directions
        if @maze.isMarked(dir, x, y)
          [nx, ny] = [x + dx(dir), y + dy(dir)]
          continue if @steps[ny][nx]?
          @steps[ny][nx] = distance + 1
          newFrontier.push [nx, ny]

    @frontier = newFrontier
    @rerender()
    true

  renderBackground: (ctx) ->
    super ctx

    for y in [0..@maze.height-1]
      for x in [0..@maze.width-1]
        continue unless @steps[y][x]?
        intensity = 64 + (@longestPath - @steps[y][x]) * 191 // @longestPath
        ctx.fillStyle = "rgb(#{intensity},#{intensity},#{intensity//2})"

        x1 = Math.round(x * @dx)
        y1 = Math.round(y * @dy)
        ctx.fillRect(x1, y1, Math.ceil(@dx), Math.ceil(@dy))

    ctx.fillStyle = "#afafff"
    for [x, y] in @frontier
      x1 = Math.round(x * @dx)
      y1 = Math.round(y * @dy)
      ctx.fillRect(x1, y1, Math.ceil(@dx), Math.ceil(@dy))

window.generateDijkstra = (id, size) ->
  canvas = document.getElementById id
  dijkstra = new Dijkstra id, size, size
  dijkstra.rerender()
  canvas.dijkstra = dijkstra
  return

window.resetDijkstra = (id) ->
  canvas = document.getElementById id
  canvas.dijkstra?.reset()
  return

window.updateDijkstra = (id) ->
  canvas = document.getElementById id
  canvas.dijkstra?.update()
  return

window.runDijkstra = (id) ->
  canvas = document.getElementById id
  canvas.dijkstra?.run()
  return
