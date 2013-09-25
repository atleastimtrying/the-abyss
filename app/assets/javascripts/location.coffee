class window.Location
  constructor: ()->
    $('body').on('getLocation', @get)

  get: (event, options)->
    $.get 'plots/fetch', {x: options.x, y: options.y}, (data)->
      options.fn data