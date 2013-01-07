# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
class App 
  constructor: ->
    @plot =
      id: $('div').data('id')
      x: $('div').data('x')
      y: $('div').data('y')
      title: $('div h2').html()
      description: $('div section').html()
    $('nav a').click @navClick

  updateDom: (plot)=>
    if plot
      @plot = plot
      $('div').data 'id', plot.id
      $('div').data 'x', plot.x
      $('div').data 'y', plot.y
      $('div h2').html plot.title
      $('div section').append "<p>#{plot.description}</p>"
    else
      $('div h2').html 'Nothingness'
      $('div section').append "<p>you have reached the edge of the abyss nothing is here.</p>"
    @scrollDown()

  scrollDown: ->
    objDiv = $ "section"
    objDiv[0].scrollTop = objDiv[0].scrollHeight
  
  navClick: (event)=>
    element = $ event.currentTarget
    @requestPage element.attr('href').substring 1
    false

  requestPage: (action)=>
    $('div section').append "<p class='action'>You travelled #{action}.</p>"
    x = @plot.x
    y = @plot.y
    y += 1 if action is 'north'
    y -= 1 if action is 'south'
    x += 1 if action is 'east'
    x -= 1 if action is 'west'
    $.get "/plots/fetch.json",
      x: x
      y: y
    , @updateDom

$ ->
  window.app = new App