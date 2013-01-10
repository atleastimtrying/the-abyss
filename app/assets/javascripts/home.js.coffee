# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class Navigator
  constructor: (@app)->
    @plot =
      id: $('div').data('id')
      x: $('div').data('x')
      y: $('div').data('y')
      title: $('div h2').html()
      description: $('div section').html()
    $('nav a').click @navClick

  navClick: (event)=>
    element = $ event.currentTarget
    @requestPlot element.attr('href').substring 1
    false

  requestPlot: (action)=>
    $(@app).trigger 'travel', action
    x = @plot.x
    y = @plot.y
    y += 1 if action is 'north'
    y -= 1 if action is 'south'
    x += 1 if action is 'east'
    x -= 1 if action is 'west'
    $.get "/plots/fetch.json",
      x: x
      y: y
    , @testPlot

  testPlot: (plots)=>
    plot = plots.plot
    if plots.plot
      @plot = plot
      $(@app).trigger 'showPlot', plot
    else
      $(@app).trigger 'emptyPlot'
    
    $(@app).trigger 'scrollDown'
    $(@app).trigger 'updateNav', plots

class Display
  constructor: (@app)->
    $(@app).bind 'emptyPlot', @emptyPlot
    $(@app).bind 'showPlot', @showPlot
    $(@app).bind 'travel', @travel
    $(@app).bind 'updateNav', @updateNav

  setTitle: (title)->
    $('div h2').html title

  setData: (id, x, y)->
    $('div').data 'id', id
    $('div').data 'x', x
    $('div').data 'y', y

  updateNav: (event, plots)=>
    @updateDirectionLabel 'north', plots['north']
    @updateDirectionLabel 'south', plots['south']
    @updateDirectionLabel 'east', plots['east']
    @updateDirectionLabel 'west', plots['west']

  updateDirectionLabel:(label, plot)=>
    message = "The Abyss"
    message = plot.title if plot
    $(".#{label}").html "#{label}: #{message}"

  append: (string)->
    $('div section').append string

  travel: (event, action)=>
    @append "<p class='action'>You travelled #{action}.</p>"

  showPlot: (event, plot)=>
    @setData plot.id, plot.x, plot.y
    @setTitle plot.title
    @append "<p>#{plot.description}</p>"

  emptyPlot: =>
    @setTitle 'Nothingness'
    @append "<p>you have reached the edge of the abyss nothing is here.</p>"

class Scroller
  constructor: (@app)->
    $(@app).bind 'scrollDown', @scrollDown
  scrollDown: ->
    objDiv = $ "section"
    objDiv[0].scrollTop = objDiv[0].scrollHeight


class App 
  constructor: ->
    @navigator = new Navigator @
    @scroller = new Scroller @
    @display = new Display @
    #@input = new Input @

$ ->
  window.app = new App