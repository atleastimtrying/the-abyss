class window.Movement
  constructor: (@app)->
    $('body').on('north', @north)
    $('body').on('south', @south)
    $('body').on('east', @east)
    $('body').on('west', @west)

  move: (label, xmod, ymod)=>
    $('body').trigger 'print',  "you travel #{label}"
    $('body').trigger 'getUser', (user)->
      x = user.x + xmod
      y = user.y + ymod
      $('body').trigger 'updateUser', { x: x, y: y }
      $('body').trigger 'getLocation',
        x: x, 
        y: y, 
        fn: (data)-> $('body').trigger('printPlot', data)
  north: => @move('north', 0, 1)
  south: => @move('south', 0, -1)
  east: => @move('east', 1, 0)
  west: => @move('west', -1, 0)