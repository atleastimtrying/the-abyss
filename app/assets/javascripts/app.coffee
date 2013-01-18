# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
class window.App 
  constructor: ->
    @user = no
    @loggedin = no
    $(@).bind 'loggedout', @loggedout
    $(@).bind 'loggedin', @loggedin
    @navigator = new Navigator @
    @scroller = new Scroller @
    @display = new Display @
    @modals = new Modals @
    #@input = new Input @

  loggedout: =>
    @app.user = no
    @app.loggedin = no

  loggedin: (event, user)=>
    @app.user = user
    @app.loggedin = yes

$ ->
  window.app = new App