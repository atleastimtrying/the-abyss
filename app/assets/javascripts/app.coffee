location = 
  get: (x, y, fn)->
    $.get 'plots/fetch', {x: x, y: y}, (data)->
      fn data

storage = 
  establishUser: ->
    user = storage.getUser()
    if user
      location.get user.x, user.y, printPlot
    else
      storage.createUser()
      location.get 0, 0, printPlot

  getUser: ->
    JSON.parse localStorage.getItem 'abyssUser'

  createUser: ->
    storage.updateUser 0, 0

  updateUser: (x,y)->
    localStorage.setItem 'abyssUser', JSON.stringify { x: x, y: y }

commands =
  'help': ->
    print 'The abyss is played by entering text commands in the window below here are some of the commands available'
    print 'help : will bring up this screen to remind you of your options'
    print 'look : will show you the description of where you are'
    print 'north : will take you one area north'
    print 'south : will take you one area south'
    print 'east : will take you one area east'
    print 'west : will take you one area west'
  
  'north': -> 
    print 'you travel north'
    user = storage.getUser()
    y = user.y
    y += 1
    storage.updateUser(user.x, y)
    location.get user.x, y, printPlot

  'south': ->
    print 'you travel south'
    user = storage.getUser()
    y = user.y
    y -= 1
    storage.updateUser(user.x, y)
    location.get user.x, y, printPlot
  
  'east': ->
    print 'you travel east'
    user = storage.getUser()
    x = user.x
    x += 1
    storage.updateUser(x, user.y)
    location.get x, user.y, printPlot
  
  'west': ->
    print 'you travel west'
    user = storage.getUser()
    x = user.x
    x -= 1
    storage.updateUser(x, user.y)
    location.get x, user.y, printPlot
  
  'look': ->
    print 'you look around you'
    user = storage.getUser()
    location.get user.x, user.y, printPlot

  'write': ->
    user = storage.getUser()
    location.get user.x, user.y, (data)->
      if data.plot.title is "The Abyss"
        $('#writeModal').show()
      else
        print "you can&rsquo;t overwrite this plot, sorry!"

interpret = (command)->
  if command isnt ''
    potential = commands[command]
    if potential
      potential() 
    else
      print "Although #{command} sounds like a great idea, It doesn&rsquo;t seem to be the right thing to do right now."

print = (message)->
  $('article').append message + '<br>'
  $('html, body').animate {
    scrollTop: $(document).height()
  }, 'slow'

processNewPlot = ->
  user = storage.getUser()
  info = 
    title: $('#plotTitle').val()
    description: $('#plotContent').html()
    x: user.x
    y: user.y
  $.post '/plots.json', info, (data)->
    console.log data

printPlot = (plot)->
  print '<h2>' + plot.plot.title + '</h2>'
  print plot.plot.description
  print "To the north lies #{plot.north.title}, south lies #{plot.south.title}, east lies #{plot.east.title} and to the west lies #{plot.west.title}"

readInput = (event)->
  input = $ @
  if event.keyCode is 13
    print "<span class='input'>#{input.val()}</span>"
    interpret input.val()
    input.val('')

$ ->
  $('#input').focus()
  $('#input').on('keyup', readInput)
  $('#writeModal .close').on 'click', ->
    $('#writeModal').hide()
    print "You closed the create plot window."
  $('#writeModal #submit').on 'click', processNewPlot
  print('<h1>Welcome to the abyss, a text adventure game type &ldquo;help&rdquo; for a list of commands.</h1>');
  
  if window.localStorage
    storage.establishUser()
  else
    print 'you will need a modern browser with local storage to persist your game, we reccommend google chrome.'