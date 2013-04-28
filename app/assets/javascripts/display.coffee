class window.Display
  constructor: (@app)->
    $(@app).bind 'emptyPlot', @emptyPlot
    $(@app).bind 'showPlot', @showPlot
    $(@app).bind 'travel', @travel
    $(@app).bind 'updateNav', @updateNav

  setTitle: (title)->
    $('div h2').html title

  setData: (id, x, y)->
    $('div').data 'id', id if id
    $('div').data 'x', x
    $('div').data 'y', y
    $(@app).trigger 'mapUpdate', x, y

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
    element = $ string
    $('div section').append(element)
    element.slideDown(1000)

  travel: (event, action)=>
    @append "<p class='action'>You travelled <span class='direction'>#{action}</span>.</p>"
    $('section p.author').remove()

  showPlot: (event, plot)=>
    @setData plot.id, plot.x, plot.y
    @setTitle plot.title
    @append "<p style='display:none;'>#{plot.description}</p>"