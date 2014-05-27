class window.Tremaux extends RenderedMaze
  BACKTRACKED: 1 << 8

  constructor: (id, width, height) ->
    super id, width, height, (maze) =>
      maze.thin 50
      [pathLength, @startX, @startY, @endX, @endY] = maze.findLongestPath()

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

  renderBackground: (ctx) ->
    super ctx

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
