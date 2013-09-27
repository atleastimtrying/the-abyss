class window.Printer
  constructor: ()->
    $('body').on 'print', @print
    $('body').on 'printPlot', @printPlot 
  print: (event, message)->
    $('article').append message + '<br>'
    $('html, body').animate {
      scrollTop: $(document).height()
    }, 'slow'
  printPlot: (event, plot)=>
    @print null, '<h2>' + plot.plot.title + '</h2>'
    @print null, plot.plot.description
    @print null, "To the <span class=\"highlight\">north</span> lies #{plot.north.title}, <span class=\"highlight\">south</span> lies #{plot.south.title}, <span class=\"highlight\">east</span> lies #{plot.east.title} and to the <span class=\"highlight\">west</span> lies #{plot.west.title}"
