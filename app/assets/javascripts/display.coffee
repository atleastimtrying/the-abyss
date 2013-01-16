class window.Display
  constructor: (@app)->
    $(@app).bind 'emptyPlot', @emptyPlot
    $(@app).bind 'showPlot', @showPlot
    $(@app).bind 'travel', @travel
    $(@app).bind 'updateNav', @updateNav
    $(@app).bind 'loggedin', @loggedin
    $(@app).bind 'loggedout', @loggedout

  setTitle: (title)->
    $('div h2').html title

  setData: (id, x, y)->
    $('div').data 'id', id
    $('div').data 'x', x
    $('div').data 'y', y

  updateNav: (event, plots)=>
    @updateDirectionLabel 'north', plots['north']
    @updateDirectionLabel 'south', plots['south']
    @updateDirectionLabel 'east', plots['east']
    @updateDirectionLabel 'west', plots['west']

  updateDirectionLabel:(label, plot)=>
    message = "The Abyss"
    message = plot.title if plot
    $(".#{label}").html "#{label}: #{message}"

  append: (string)->
    $('div section').append string

  travel: (event, action)=>
    @append "<p class='action'>You travelled #{action}.</p>"
    $('section p.author').remove()

  showPlot: (event, plot)=>
    @setData plot.id, plot.x, plot.y
    @setTitle plot.title
    @append "<p>#{plot.description}</p>"

  loggedin: (event)=>
    $('.in').show()
    $('.out').hide()

  loggedout: (event)=>
    $('.in').hide()
    $('.out').show()

  emptyPlot: =>
    @setTitle 'The Abyss'
    @append "<p>You have reached the edge of the abyss nothing is here.</p><p class='author'>To change this you can <a href='#' class='modal-launcher' data-modal-id='newplot'>write it</a></p>"