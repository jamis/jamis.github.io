class window.AStar extends BestFirstSearch

  nodeComparison: (a, b) ->
    adist = Math.abs(a[0] - @endX) + Math.abs(a[1] - @endY) + a[3]
    bdist = Math.abs(b[0] - @endX) + Math.abs(b[1] - @endY) + b[3]
    adist <= bdist


window.generateAStar = (id, size, options) ->
  canvas = document.getElementById id
  canvas.astar?.stop()

  astar = new AStar id, size, size, options
  astar.rerender()

  canvas.astar = astar
  return

window.resetAStar = (id) ->
  canvas = document.getElementById id
  canvas.astar?.reset()
  return

window.updateAStar = (id) ->
  canvas = document.getElementById id
  canvas.astar?.update()
  return

window.runAStar = (id, delay) ->
  canvas = document.getElementById id
  canvas.astar?.run(delay)
  return
