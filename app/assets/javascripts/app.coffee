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

move = (label, xmod, ymod)->
  print "you travel #{label}"
  user = storage.getUser()
  x = user.x + xmod
  y = user.y + ymod
  storage.updateUser(x,y)
  location.get x, y, printPlot
north = ->  move('north', 0, 1)
south = -> move('south', 0, -1)
east = -> move('east', 1, 0)
west = -> move('west', -1, 0)
commands =
  'help': ->
    print 'The abyss is played by entering text commands in the window below here are some of the commands available'
    print '<span class="highlight">help</span> : will bring up this screen to remind you of your options'
    print '<span class="highlight">look</span> : will show you the description of where you are'
    print '<span class="highlight">north</span> : will take you one area north'
    print '<span class="highlight">south</span> : will take you one area south'
    print '<span class="highlight">east</span> : will take you one area east'
    print '<span class="highlight">west</span> : will take you one area west'
    print '<span class="highlight">write</span> : will allow you to overwrite the abyss with your own plot'
    print '<span class="highlight">home</span> : will take you back to the entrance'
    print '<span class="highlight">where</span> : will tell you your current coordinates'
  
  'north': north
  'n': north
  'south': south
  's': south
  'east': east
  'e': east
  'west': west
  'w': west
  'grid': ->
    window.location = '/grid'
  'home': ->
    print 'With a twist in reality you are transported back'
    storage.updateUser 0, 0
    location.get 0, 0, printPlot
  
  'where': ->
    user = storage.getUser()
    print "By looking at the stars, some moss and the curve of the horizon you determine that your coordinates must be <br> <span class='highlight'>#{user.x}, #{user.y}</span>!"

  'look': ->
    print 'you look around you'
    user = storage.getUser()
    location.get user.x, user.y, printPlot

  'write': ->
    user = storage.getUser()
    location.get user.x, user.y, (data)->
      if data.plot.title is "The Abyss"
        $('#writeModal').slideDown ->
          $('#input').hide()
          $('#plotTitle').focus()
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
    if data.title
      closeModal()
      print "You look up from your writings to see that the things you have written have come into being, well done."
      commands['look']()

printPlot = (plot)->
  print '<h2>' + plot.plot.title + '</h2>'
  print plot.plot.description
  print "To the <span class=\"highlight\">north</span> lies #{plot.north.title}, <span class=\"highlight\">south</span> lies #{plot.south.title}, <span class=\"highlight\">east</span> lies #{plot.east.title} and to the <span class=\"highlight\">west</span> lies #{plot.west.title}"

readInput = (event)->
  input = $ @
  if event.keyCode is 13
    print "<span class='input'>#{input.val()}</span>"
    interpret input.val()
    input.val('')

closeModal = ->
  $('#plotTitle, #plotContent').val('')
  $('#writeModal').slideUp ->
    $('#input').show().focus()

$ ->
  if $('#grid-container')[0]
    gc = $('#grid-container')
    g = $('#grid')
    gc.scrollTop(g.height()/2 - gc.height()/2)
    gc.scrollLeft(g.width()/2 - gc.width()/2)
  if $('#input')[0]
    $('#input').focus()
    $('#input').on('keyup', readInput)
    $('#writeModal .close').on 'click', closeModal
    $('#writeModal #submit').on 'click', processNewPlot
    print('<h1>Welcome to the abyss, a text adventure game type <span class=\"highlight\">help</span> for a list of commands.</h1>');
    if window.localStorage
      storage.establishUser()
    else
      print 'you will need a modern browser with local storage to persist your game, we reccommend google chrome.'