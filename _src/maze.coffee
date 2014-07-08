class Maze
  N: 1 << 0
  S: 1 << 1
  E: 1 << 2
  W: 1 << 3

  constructor: (@width, @height, options) ->
    options ?= {}
    @grid = ((0 for x in [1..@width]) for y in [1..@height])

    @rand = new MersenneTwister(options.seed)
    @rand.randomElement = (list) -> list[@nextInteger(list.length)]
    @rand.shuffleList = (list) ->
      i = list.length - 1
      while i > 0
        j = @nextInteger(i+1)
        [list[i], list[j]] = [list[j], list[i]]
        i--
      list

    @generate()

  mark: (fromX, fromY, bits) ->
    @grid[fromY][fromX] |= bits

  unmark: (fromX, fromY, bits) ->
    @grid[fromY][fromX] &= ~bits

  isMarked: (bits, fromX, fromY) ->
    (@grid[fromY][fromX] & bits) == bits

  utilities: ->
    functions =
      dx: (dir) =>
        switch dir
          when @N, @S then 0
          when @E then 1
          when @W then -1
      dy: (dir) =>
        switch dir
          when @E, @W then 0
          when @N then -1
          when @S then 1
      opposite: (dir) =>
        switch dir
          when @W then @E
          when @E then @W
          when @N then @S
          when @S then @N
      directions: [ @N, @S, @E, @W ]

  generate: ->
    { dx, dy, opposite, directions } = @utilities()

    stack = [[@rand.nextInteger(@width), @rand.nextInteger(@height)]]
    while stack.length > 0
      #index = stack.length - 1
      #index = @rand.nextInteger(stack.length)
      index = if @rand.nextBoolean() then @rand.nextInteger(stack.length) else stack.length-1
      [x, y] = stack[index]

      found = false
      for dir in @rand.shuffleList(directions[..])
        [nx, ny] = [x+dx(dir), y+dy(dir)]
        if 0 <= nx < @width && 0 <= ny < @height && @grid[ny][nx] == 0
          found = true
          @grid[y][x] |= dir
          @grid[ny][nx] |= opposite(dir)
          stack.push([nx, ny])
          break

      if !found
        stack[index..index] = []

  thin: (rate) ->
    { dx, dy, opposite, directions } = @utilities()

    for y in [0..@height-1]
      for x in [0..@width-1]
        cell = @grid[y][x]
        if cell == @N || cell == @S || cell == @E || cell == @W
          if @rand.nextInteger(100) < rate
            for dir in @rand.shuffleList(directions[..])
              continue if cell == dir
              [nx, ny] = [x+dx(dir), y+dy(dir)]
              if 0 <= nx < @width && 0 <= ny < @height
                @grid[y][x] |= dir
                @grid[ny][nx] |= opposite(dir)
                break

  findDistances: (fromX, fromY) ->
    { dx, dy, opposite, directions } = @utilities()
    frontier = [[fromX,fromY]]
    distances = ((undefined for x in [1..@width]) for y in [1..@height])
    distances[fromY][fromX] = 0
    longest = 0
    farthestPoint = null

    while frontier.length > 0
      newFrontier = []

      for [x, y] in frontier
        distance = distances[y][x]

        for dir in directions
          if @isMarked(dir, x, y)
            [nx, ny] = [x+dx(dir), y+dy(dir)]
            unless distances[ny][nx]?
              if distance+1 > longest
                longest = distance+1
                farthestPoint = [nx, ny]
              distances[ny][nx] = distance + 1
              newFrontier.push([nx, ny])

      frontier = newFrontier

    [distances, longest, farthestPoint]

  findMostDistantPoints: ->
    # find the most distant point from an arbitrary point
    [distances, longestPath, [startX, startY]] = @findDistances(0, 0)
    # find the most distant point from THAT point
    [distances, longestPath, [endX, endY]]     = @findDistances(startX, startY)

    [longestPath, startX, startY, endX, endY]

  findPathBetween: (startX, startY, endX, endY) ->
    # find the shortest paths from startX,startY
    [distances, longestPath, [farX, farY]] = @findDistances(startX, startY)

    { dx, dy, opposite, directions } = @utilities()

    path = [[endX, endY]]
    [x, y] = [endX, endY]
    while not (x == startX && y == startY)
      for direction in directions
        continue unless @isMarked(direction, x, y)
        [nx, ny] = [x + dx(direction), y + dy(direction)]
        if distances[ny][nx] == distances[y][x]-1
          path.push [nx, ny]
          [x, y] = [nx, ny]

    [startX, startY, endX, endY, path]

  findLongestPath: ->
    # find the most distant point from an arbitrary point
    [distances, longestPath, [startX, startY]] = @findDistances(0, 0)
    # find the most distant point from THAT point
    [distances, longestPath, [endX, endY]]     = @findDistances(startX, startY)

    @findPathBetween(startX, startY, endX, endY)
