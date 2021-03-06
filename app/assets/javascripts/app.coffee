class App 
  constructor: ->
    @storage = new Storage()
    @location = new Location()
    @printer = new Printer()
    @commands = new Commands()
    @movement = new Movement()
    @ui = new UI()    
    $('body').trigger 'print',  '<h1>Welcome to the abyss, a text adventure game type <span class=\"highlight\">help</span> for a list of commands.</h1>'
    $('body').trigger 'establishUser'
$ ->
  window.grid = new Grid() if $('#grid-container')[0]
  window.app = new App() if $('#input')[0]
