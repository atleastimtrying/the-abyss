class window.Navigator
  constructor: (@app)->
    @plot =
      id: $('div').data('id')
      x: $('div').data('x')
      y: $('div').data('y')
      title: $('div h2').html()
      description: $('div section').html()
    $('article nav a').click @navClick

  navClick: (event)=>
    element = $ event.currentTarget
    @requestPlot element.attr('href').substring 1
    false

  requestPlot: (action)=>
    $(@app).trigger 'travel', action
    x = @plot.x
    y = @plot.y
    y += 1 if action is 'north'
    y -= 1 if action is 'south'
    x += 1 if action is 'east'
    x -= 1 if action is 'west'
    $.get "/plots/fetch.json",
      x: x
      y: y
    , @testPlot

  testPlot: (plots)=>
    plot = plots.plot
    if plots.plot
      @plot = plot
      $(@app).trigger 'showPlot', plot
    else
      $(@app).trigger 'emptyPlot'
    
    $(@app).trigger 'scrollDown'
    $(@app).trigger 'updateNav', plots