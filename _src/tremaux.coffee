class window.Tremaux
  BACKTRACKED: 1 << 8

  constructor: (id, width, height) ->
    @canvas = document.getElementById id
    @maze = new Maze(width, height)
    @maze.thin 50

    [pathLength, @startX, @startY, @endX, @endY] = @maze.findLongestPath()

    @dx = @canvas.width / @maze.width
    @dy = @canvas.height / @maze.height

    wd = Math.round(@maze.width * @dx)
    ht = Math.round(@maze.height * @dx)

    @walls = []
    @walls.push [0, 0, wd, 0]
    @walls.push [0, 0, 0, ht]
    @walls.push [0, ht, wd, ht]
    @walls.push [wd, 0, wd, ht]

    for y in [0..@maze.height-1]
      for x in [0..@maze.width-1]
        x1 = Math.round(x * @dx)
        y1 = Math.round(y * @dy)
        x2 = Math.round((x+1) * @dx)
        y2 = Math.round((y+1) * @dy)

        if x+1 < @maze.width && !@maze.isMarked(@maze.E, x, y)
          @walls.push [x2, y1, x2, y2]
        if y+1 < @maze.height && !@maze.isMarked(@maze.S, x, y)
          @walls.push [x1, y2, x2, y2]

        if x == @startX && y == @startY
          @startCell = [x1+2, y1+2, Math.round(@dx)-4, Math.round(@dy)-4]
        if x == @endX && y == @endY
          @endCell = [x1+2, y1+2, Math.round(@dx)-4, Math.round(@dy)-4]

    @resetVisitations()

  resetVisitations: ->
    for y in [0..@maze.height-1]
      for x in [0..@maze.width-1]
        @maze.unmark x, y, @BACKTRACKED

    [@positionX, @positionY] = [@startX, @startY]
    @visits = ((undefined for x in [1..@maze.width]) for y in [1..@maze.height])
    @visits[@positionY][@positionX] = 0

  solve: (speed) ->
    unless @timer?
      @resetVisitations()
      @timer = window.setInterval((=> @update()), 1000 / speed)

  update: ->
    stepCount = @visits[@positionY][@positionX]

    { dx, dy, opposite, directions } = @maze.utilities()
    bestX = bestY = undefined

    for dir in @maze.rand.shuffleList(directions[..])
      continue unless @maze.isMarked(dir, @positionX, @positionY)
      [nx, ny] = [@positionX+dx(dir), @positionY+dy(dir)]
      if !@visits[ny][nx]?
        [bestX, bestY] = [nx, ny]
        break
      else if !bestX? && @visits[ny][nx] == stepCount-1
        [bestX, bestY] = [nx, ny]

    if @visits[bestY][bestX] == stepCount - 1
      @maze.mark(@positionX, @positionY, @BACKTRACKED)
    else
      @visits[bestY][bestX] = stepCount+1

    [@positionX , @positionY] = [bestX, bestY]
    if @positionX == @endX && @positionY == @endY
      window.clearInterval(@timer)
      @timer = null

    @render()

  render: ->
    @canvas.width = @canvas.width
    ctx = @canvas.getContext "2d"

    for y in [0..@maze.height-1]
      for x in [0..@maze.width-1]
        continue if !@visits[y][x]?
        if @maze.isMarked(@BACKTRACKED, x, y)
          ctx.fillStyle = "#aaaaaa"
        else
          ctx.fillStyle = "#ffffaa"

        x1 = Math.round(x * @dx)
        y1 = Math.round(y * @dy)

        ctx.fillRect(x1, y1, Math.round(@dx), Math.round(@dy))

    ctx.fillStyle = "red"
    ctx.fillRect(@startCell[0], @startCell[1], @startCell[2], @startCell[3])

    ctx.fillStyle = "green"
    ctx.fillRect(@endCell[0], @endCell[1], @endCell[2], @endCell[3])

    ctx.beginPath()
    for [x1, y1, x2, y2] in @walls
      ctx.moveTo(x1, y1)
      ctx.lineTo(x2, y2)
    ctx.stroke()

window.generateTremaux = (id) ->
  canvas = document.getElementById id
  if canvas.tremaux?.timer?
    window.clearInterval(canvas.tremaux.timer)

  tremaux = new Tremaux id, 20, 20
  tremaux.render()

  canvas.tremaux = tremaux

window.solveTremaux = (id) ->
  canvas = document.getElementById id
  tremaux = canvas.tremaux
  tremaux.solve 50
