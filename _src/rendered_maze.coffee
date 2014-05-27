class window.RenderedMaze
  constructor: (id, width, height, callback) ->
    @canvas = document.getElementById id
    @maze = new Maze(width, height)

    callback?(@maze)

    @dx = @canvas.width / @maze.width
    @dy = @canvas.height / @maze.height

    if @startX? && @startY?
      @startCell = [
        Math.round(@startX*@dx)+2,
        Math.round(@startY*@dy)+2,
        Math.round(@dx)-5,
        Math.round(@dy)-5]

    if @endX? && @endY?
      @endCell = [
        Math.round(@endX*@dx)+2,
        Math.round(@endY*@dy)+2,
        Math.round(@dx)-5,
        Math.round(@dy)-5]

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

  renderBackground: (ctx) ->

  render: ->
    @canvas.width = @canvas.width
    ctx = @canvas.getContext "2d"

    @renderBackground ctx

    if @startCell?
      ctx.fillStyle = "red"
      ctx.fillRect(@startCell[0], @startCell[1], @startCell[2], @startCell[3])

    if @endCell?
      ctx.fillStyle = "green"
      ctx.fillRect(@endCell[0], @endCell[1], @endCell[2], @endCell[3])

    ctx.beginPath()
    for [x1, y1, x2, y2] in @walls
      ctx.moveTo(x1, y1)
      ctx.lineTo(x2, y2)
    ctx.stroke()

