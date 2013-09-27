class window.Storage
  constructor: ()->
    $('body').on 'getUser', @getUser
    $('body').on 'updateUser', @updateUser
    if window.localStorage
      @establishUser()
    else
      $('body').trigger 'print', 'you will need a modern browser with local storage to persist your game, we reccommend google chrome.'
 
  establishUser: =>
    $('body').trigger 'getUser', (user)=>
      if user
        $('body').trigger 'getLocation',
          x: user.x, 
          y: user.y, 
          fn: (data)-> $('body').trigger('printPlot', data)
      else
        @createUser()
        $('body').trigger 'getLocation',
          x: 0, 
          y: 0, 
          fn: (data)-> $('body').trigger('printPlot', data)

  getUser: (event,fn)->
    fn JSON.parse localStorage.getItem 'abyssUser'

  createUser: =>
    @updateUser null, { x: 0, y: 0 }

  updateUser: (event, options)->
    localStorage.setItem 'abyssUser', JSON.stringify options