# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
class window.App 
  constructor: ->
    @navigator = new Navigator @
    @scroller = new Scroller @
    @display = new Display @
    @modals = new Modals @
$ ->
  window.app = new App