class window.Scroller
  constructor: (@app)->
    $(@app).bind 'scrollDown', @scrollDown
  scrollDown: ->
    objDiv = $ "section"
    objDiv[0].scrollTop = objDiv[0].scrollHeight