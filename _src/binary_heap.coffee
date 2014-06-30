class window.BinaryHeap
  constructor: (@higher) ->
    @list = []

  insert: (value) ->
    @list.push value

    child = @list.length - 1
    while child > 0
      parent = (child - 1) // 2
      if @higher(@list[child], @list[parent])
        [@list[child], @list[parent]] = [@list[parent], @list[child]]
        child = parent
      else
        break

    this

  buildHeap: (list) ->
    @list = list.slice()
    @reheapify()

  isEmpty: -> @list.length == 0

  peek: -> @list[0]

  delete: ->
    value = @list[0]
    least = @list.pop()

    if @list.length > 0
      @list[0] = least
      @heapifyFrom(0)

    value

  reheapify: ->
    mid = (@list.length - 2) / 2
    for i in [mid..0]
      @heapifyFrom(i)
    this

  heapifyFrom: (root) ->
    left  = root * 2 + 1
    right = root * 2 + 2

    highest = root

    if right < @list.length && @higher(@list[right], @list[root]) && @higher(@list[right], @list[left])
      highest = right
    else if left < @list.length && @higher(@list[left], @list[root])
      highest = left

    if highest != root
      [@list[root], @list[highest]] = [@list[highest], @list[root]]
      @heapifyFrom(highest)
