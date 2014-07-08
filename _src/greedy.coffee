class window.Greedy extends BestFirstSearch

  nodeComparison: (a, b) ->
    adist = Math.abs(a[0] - @endX) + Math.abs(a[1] - @endY)
    bdist = Math.abs(b[0] - @endX) + Math.abs(b[1] - @endY)
    adist <= bdist


window.generateGreedy = (id, size, options) ->
  canvas = document.getElementById id
  canvas.greedy?.stop()

  greedy = new Greedy id, size, size, options
  greedy.rerender()

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
