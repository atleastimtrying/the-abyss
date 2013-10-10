class window.Movement
  constructor: (@app)->
    $('body').on('north', @north)
    $('body').on('south', @south)
    $('body').on('east', @east)
    $('body').on('west', @west)

  blocked: (plot, label)->
    current_plot = plot.plot
    switch label
      when "north" then current_plot.north_wall or plot.north.south_wall
      when "south" then current_plot.south_wall or plot.south.north_wall
      when "east" then current_plot.east_wall or plot.east.west_wall
      when "west" then current_plot.west_wall or plot.west.east_wall

  travel: (xmod, ymod, user)=>
    x = user.x + xmod
    y = user.y + ymod
    $('body').trigger 'getLocation',
      x: x, 
      y: y, 
      fn: (data)-> 
        $('body').trigger('printPlot', data)
        $('body').trigger 'updateUser', { x: x, y: y }

  move: (label, xmod, ymod)=>
    $('body').trigger 'getUser', (user)=>
      $('body').trigger 'getLocation',
        x: user.x, 
        y: user.y, 
        fn: (plot)=> 
          if @blocked(plot, label)
            $('body').trigger('print', "The way to the #{label} is barred!")
          else
            $('body').trigger 'print',  "You travel #{label}"
            @travel(xmod, ymod, user)
  
  north: => @move('north', 0, 1)
  south: => @move('south', 0, -1)
  east: => @move('east', 1, 0)
  west: => @move('west', -1, 0)