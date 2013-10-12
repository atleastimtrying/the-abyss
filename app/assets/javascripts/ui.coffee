class window.UI
  constructor: (@app)->
    $('#input').focus()
    $('#input').on 'keyup', @readInput
    $('#writeModal .close').on 'click', @closeModal
    $('#writeModal #submit').on 'click', @processNewPlot

  processNewPlot: =>
    $('body').trigger 'getUser', (user)=>
      info = 
        title: $('#plotTitle').val()
        description: $('#plotContent').html()
        north_wall: $('#north_wall').prop('checked')
        south_wall: $('#south_wall').prop('checked')
        east_wall: $('#east_wall').prop('checked')
        west_wall: $('west_wall').prop('checked')
        x: user.x
        y: user.y
      $.post '/plots.json', info, (data)=>
        if data.title
          @closeModal()
          $('body').trigger 'print', "As you finish writing your plot into existence it disappears into the nether,<br> in time if it is worthy the plot will appear in this place."  

  readInput: (event)=>
    input = $ event.currentTarget
    if event.keyCode is 13
      $('body').trigger 'print', "<span class='input'>#{input.val()}</span>"
      $('body').trigger('command', input.val())
      input.val('')

  closeModal: ->
    $('#plotTitle, #plotContent').val('')
    $('#writeModal').slideUp ->
      $('#input').show().focus()