class window.Grid
  constructor: ->
    gc = $('#grid-container')
    g = $('#grid')
    gc.scrollTop(g.height()/2 - gc.height()/2)
    gc.scrollLeft(g.width()/2 - gc.width()/2)