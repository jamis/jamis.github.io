class window.ColoredMaze extends RenderedMaze

  constructor: (id, width, height, seed) ->
    chooseElement = @setupStyle seed

    super id, width, height, {seed, chooseElement}, (maze) =>
      @prepareMaze()

    @resetState()

  setupStyle: (seed) ->
    rand = new MersenneTwister(seed)

    @color = switch rand.nextInteger(7)
      when 0 then "rgb({c},0,0)"
      when 1 then "rgb(0,{c},0)"
      when 2 then "rgb(0,0,{c})"
      when 3 then "rgb({c},{c},0)"
      when 4 then "rgb({c},0,{c})"
      when 5 then "rgb(0,{c},{c})"
      when 6 then "rgb({c},{c},{c})"

    switch rand.nextInteger(4)
      when 0
        (rand, count) -> if rand.nextInteger(100) < 95 then count-1 else rand.nextInteger(count)
      when 1
        (rand, count) -> rand.nextInteger(count)
      when 2
        (rand, count) -> if rand.nextInteger(100) < 75 then count-1 else rand.nextInteger(count)
      when 3
        (rand, count) -> if rand.nextInteger(100) < 25 then count-1 else rand.nextInteger(count)

  prepareMaze: ->
    if @maze.rand.nextBoolean()
      @maze.thin @maze.rand.nextInteger(50)

    [@beginX, @beginY] = [@maze.rand.nextInteger(@maze.width), @maze.rand.nextInteger(@maze.height)]
    [distances, @longestPath, [x, y]] = @maze.findDistances(@beginX, @beginY)

  onclick: (e) ->
    if @frontier.length > 0
      if e.offsetX?
        posX = e.offsetX
        posY = e.offsetY
      else
        posX = e.pageX - @canvas.offsetLeft
        posY = e.pageY - @canvas.offsetTop

      @beginX = posX // @dx
      @beginY = posY // @dy

      @beginX = @maze.width - 1 if @beginX >= @maze.width
      @beginY = @maze.height - 1 if @beginY >= @maze.height

      [distances, @longestPath, [x, y]] = @maze.findDistances(@beginX, @beginY)

      @reset()
      @run(5)

    else
      @maze.chooseElement = @setupStyle()
      @maze.regenerate()
      @prepareMaze()
      @recomputeMetrics()
      @reset()

  resetState: ->
    @frontier = [[@beginX, @beginY]]
    @steps = ((undefined for x in [1..@maze.width]) for y in [1..@maze.height])
    @steps[@beginY][@beginX] = 0

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

  setWallColor: (ctx) ->
    distance = if @frontier[0]?
        [nx, ny] = @frontier[0]
        @steps[ny][nx]
      else
        @longestPath

    ctx.strokeStyle = "rgba(0, 0, 0, #{(@longestPath - distance) / @longestPath})"

  renderBackground: (ctx) ->
    super ctx

    # don't color cells if the timer hasn't been set yet
    return unless @timer?

    for y in [0..@maze.height-1]
      for x in [0..@maze.width-1]
        continue unless @steps[y][x]?
        intensity = (@longestPath - @steps[y][x]) * 255 // @longestPath
        ctx.fillStyle = @color.replace(/{c}/g, intensity.toString())

        x1 = Math.round(x * @dx)
        y1 = Math.round(y * @dy)
        ctx.fillRect(x1, y1, Math.ceil(@dx), Math.ceil(@dy))

window.generateColors = (id, width, height) ->
  canvas = document.getElementById id
  canvas.colors?.reset()

  colors = new ColoredMaze id, width, height ? width
  colors.rerender()
  canvas.colors = colors
  canvas.onclick = (e) => colors.onclick(e)
  return

window.resetColors = (id) ->
  canvas = document.getElementById id
  canvas.colors?.reset()
  return

window.updateColors = (id) ->
  canvas = document.getElementById id
  canvas.colors?.update()
  return

window.runColors = (id) ->
  canvas = document.getElementById id
  canvas.colors?.run(10)
  return
