class window.Commands
  constructor: ()->
    $('body').on('command', @interpret)
  
  interpret: (event, command)=>
    if command isnt ''
      potential = @commands[command]
      if potential
        potential() 
      else
        $('body').trigger 'print', "Although #{command} sounds like a great idea, It doesn&rsquo;t seem to be the right thing to do right now."
  
  commands :
    'help': ->
      $('body').trigger 'print', 'The abyss is played by entering text commands in the window below here are some of the commands available'
      $('body').trigger 'print', '<span class="highlight">help</span> : will bring up this screen to remind you of your options'
      $('body').trigger 'print', '<span class="highlight">look</span> : will show you the description of where you are'
      $('body').trigger 'print', '<span class="highlight">north</span> : will take you one area north'
      $('body').trigger 'print', '<span class="highlight">south</span> : will take you one area south'
      $('body').trigger 'print', '<span class="highlight">east</span> : will take you one area east'
      $('body').trigger 'print', '<span class="highlight">west</span> : will take you one area west'
      $('body').trigger 'print', '<span class="highlight">write</span> : will allow you to overwrite the abyss with your own plot'
      $('body').trigger 'print', '<span class="highlight">home</span> : will take you back to the entrance'
      $('body').trigger 'print', '<span class="highlight">where</span> : will tell you your current coordinates'
      $('body').trigger 'print', '<span class="highlight">grid</span> : will relocate you to the grid view'
    
    'north': -> $('body').trigger('north')
    'n': -> $('body').trigger('north')
    'south': -> $('body').trigger('south')
    's': -> $('body').trigger('south')
    'east': -> $('body').trigger('east')
    'e': -> $('body').trigger('east')
    'west': -> $('body').trigger('west')
    'w': -> $('body').trigger('west')
    'grid': -> window.location = '/grid'
    'home': ->
      $('body').trigger 'print', 'With a twist in reality you are transported back'
      $('body').trigger 'updateUser', {x: 0, y: 0}
      $('body').trigger 'getLocation',
        x: 0, 
        y: 0, 
        fn: (data)-> $('body').trigger('printPlot', data)
    
    'where': ->
      $('body').trigger 'getUser', (user)->
        $('body').trigger 'print', "By looking at the stars, some moss and the curve of the horizon you determine that your coordinates must be <br> <span class='highlight'>#{user.x}, #{user.y}</span>!"

    'look': ->
      $('body').trigger 'print', 'you look around you'
      $('body').trigger 'getUser', (user)->
        $('body').trigger 'getLocation',
          x: user.x, 
          y: user.y, 
          fn: (data)-> $('body').trigger('printPlot', data)

    'write': ->
      $('body').trigger 'getUser', (user)->
        $('body').trigger 'getLocation',
          x: user.x, 
          y: user.y, 
          fn: (data)->
            if data.plot.title is "The Abyss"
              $('#writeModal').slideDown ->
                $('#input').hide()
                $('#plotTitle').focus()
            else
              $('body').trigger 'print', "you can&rsquo;t overwrite this plot, sorry!"