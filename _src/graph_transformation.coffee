class GraphTransformation

  class Node
    constructor: (depth) ->
      @children = []
      @depth = depth ? 1

  DisplayMaze: 1
  DisplayTree: 2

  constructor: (id, @width, @height) ->
    @canvas = document.getElementById id
    @canvas.onclick = (e) => @clicked(e)
    @reset()

  clicked: (e) ->
    return if @startTime?

    if e.offsetX?
      posX = e.offsetX
      posY = e.offsetY
    else
      posX = e.pageX - @canvas.offsetLeft
      posY = e.pageY - @canvas.offsetTop

    closestNode = null
    bestDistance = 1000000

    @eachNode (node) =>
      distance = Math.abs(node.position.x - posX) + Math.abs(node.position.y - posY)
      if distance < bestDistance
        bestDistance = distance
        closestNode = node

    if @mode == @DisplayMaze
      if @selection == closestNode
        @buildTree closestNode.coords.x, closestNode.coords.y
      else
        @selection = closestNode
    else
      @selection = closestNode

    @render()

  reset: ->
    @startTime = null
    @mode = @DisplayTree

    @maze = new Maze(@width, @height)
    [x, y] = [@maze.rand.nextInteger(@maze.width), @maze.rand.nextInteger(@maze.height)]

    @buildTree x, y

  buildTree: (fromX, fromY) ->
    { dx, dy, opposite, directions } = @maze.utilities()

    visited = 0x8000
    for y in [0..@maze.height-1]
      for x in [0..@maze.width-1]
        @maze.unmark(x, y, visited)

    @selection = @root = new Node

    dw = @cellWidth = @canvas.width / @maze.width
    dh = @cellHeight = @canvas.height / @maze.height
    xpad = dw // 2
    ypad = dh // 2

    @root.coords = { x: fromX, y: fromY }
    @root.position = { x: Math.round(xpad + fromX * dw), y: Math.round(ypad + fromY * dh) }
    @root.start = { x: @root.position.x, y: @root.position.y }

    stack = [ @root ]
    widths = {}

    @deepest = 0
    widest = 0

    # construct the graph
    while stack.length > 0
      node = stack.pop()
      @maze.mark(node.coords.x, node.coords.y, visited)

      @deepest = node.depth if @deepest < node.depth
      widths[node.depth] = (widths[node.depth] ? 0) + 1

      widest = widths[node.depth] if widest < widths[node.depth]

      for direction in [ @maze.E, @maze.N, @maze.S, @maze.W ]
        if @maze.isMarked(direction, node.coords.x, node.coords.y)
          [nx, ny] = [node.coords.x + dx(direction), node.coords.y + dy(direction)]
          if !@maze.isMarked(visited, nx, ny)
            child = new Node(node.depth+1)
            child.coords = { x: nx, y: ny }
            child.position = { x: Math.round(xpad + nx * dw), y: Math.round(ypad + ny * dh) }
            child.start = { x: child.position.x, y: child.position.y }
            node.children.push child
            stack.push child

    # determine target locations
    dh = @canvas.height / @deepest
    ypad = dh // 2
    visits = {}

    stack = [ @root ]
    while stack.length > 0
      node = stack.pop()
      depth = node.depth - 1
      breadth = visits[node.depth] ? 0
      visits[node.depth] = breadth + 1

      dw = @canvas.width / widths[node.depth]
      xpad = dw // 2

      node.target = { x: Math.round(xpad + breadth * dw), y: @canvas.height - Math.round(ypad + depth * dh) }

      if @mode == @DisplayTree
        node.position.x = node.target.x
        node.position.y = node.target.y

      for child in node.children
        stack.push child

  animate: (duration) ->
    return if @startTime?
    @startTime = Date.now()
    @update(duration)

  setMode: (mode) ->
    return if mode == @mode
    @mode = mode

    @eachNode (node)=>
      if @mode == @DisplayMaze
        node.position.x = node.start.x
        node.position.y = node.start.y
      else if @mode == @DisplayTree
        node.position.x = node.target.x
        node.position.y = node.target.y

  eachNode: (fn) ->
    stack = [ @root ]
    while stack.length > 0
      node = stack.pop()

      fn(node)

      for child in node.children
        stack.push child

  step: ->
    @n ?= 0.0
    @delta ?= 1.0

    @computeAt(@n)

    @n += @delta * 0.05

    if @n > 1.0
      @n = 1.0
    else if @n < 0.0
      @n = 0.0

    if @n >= 1.0 || @n <= 0.0
      @delta *= -1

  update: (duration) ->
    t = (Date.now() - @startTime) / duration

    if t >= 1.0
      t = 1.0
      done = true
    else
      done = false
      # ease-in, ease-out
      t = -(Math.cos(Math.PI * t) - 1) / 2

    @computeAt t

    if done
      if @mode == @DisplayMaze
        @mode = @DisplayTree
      else
        @mode = @DisplayMaze
      @startTime = null
    else
      window.setTimeout((=> @update(duration)), 10)

  computeAt: (t) ->
    stack = [ @root ]
    ref = @root.children[0]

    while stack.length > 0
      node = stack.pop()

      if @mode == @DisplayMaze
        start  = node.start
        target = node.target
      else
        start  = node.target
        target = node.start

      if t >= 1.0
        node.position.x = target.x
        node.position.y = target.y
      else
        node.position.x = Math.round(start.x + t * (target.x - start.x))
        node.position.y = Math.round(start.y + t * (target.y - start.y))

      for child in node.children
        stack.push child

    @render()

  render: ->
    @canvas.width = @canvas.width
    ctx = @canvas.getContext "2d"

    ctx.beginPath()

    @eachNode (node)=>
      for child in node.children
        ctx.beginPath()
        ctx.moveTo(node.position.x, node.position.y)
        ctx.lineTo(child.position.x, child.position.y)

        ctx.strokeStyle = "#000"
        ctx.stroke()

      if node == @root
        ctx.fillStyle = "#ff0000"
        ctx.fillRect(node.position.x-5, node.position.y-5,10,10)

      if node == @selection
        ctx.strokeStyle = "7f0000"
        ctx.beginPath()
        ctx.rect(node.position.x-6, node.position.y-6,12,12)
        ctx.stroke()

      if node != @root
        intensity = (255 * (@deepest - node.depth) // @deepest)
        ctx.fillStyle = "rgb(#{intensity}, 0, 0)"
        ctx.fillRect(node.position.x-3, node.position.y-3,6,6)

window.generateTree = (id, size) ->
  canvas = document.getElementById id
  tree = new GraphTransformation id, size, size
  tree.render()
  canvas.tree = tree
  return

window.resetTree = (id) ->
  canvas = document.getElementById id
  canvas.tree?.reset()
  canvas.tree?.render()
  return

window.animateTree = (id, duration) ->
  canvas = document.getElementById id
  canvas.tree?.animate(duration)
  return

window.stepTree = (id) ->
  canvas = document.getElementById id
  canvas.tree?.step()
  return
