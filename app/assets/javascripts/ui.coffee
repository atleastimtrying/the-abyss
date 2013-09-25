class window.UI
  constructor: (@app)->
    $('#input').focus()
    $('#input').on 'keyup', @readInput
    $('#writeModal .close').on 'click', @closeModal
    $('#writeModal #submit').on 'click', @processNewPlot

  processNewPlot = ->
    $('body').trigger 'getUser', (user)=>
      info = 
        title: $('#plotTitle').val()
        description: $('#plotContent').html()
        x: user.x
        y: user.y
      $.post '/plots.json', info, (data)=>
        if data.title
          @closeModal()
          $('body').trigger 'print', "You look up from your writings to see that the things you have written have come into being, well done."  
          $('body').trigger('command', 'look')

  readInput = (event)=>
    input = $ event.currentTarget
    if event.keyCode is 13
      $('body').trigger 'print', "<span class='input'>#{input.val()}</span>"
      $('body').trigger('command', input.val())
      input.val('')

  closeModal = ->
    $('#plotTitle, #plotContent').val('')
    $('#writeModal').slideUp ->
      $('#input').show().focus()