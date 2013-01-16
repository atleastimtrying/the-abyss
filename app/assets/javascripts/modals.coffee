class window.Modals
  constructor: (@app)->
    @background = $ '.modal-background'
    @background.hide()
    $('.modal').hide()
    $('.modal-launcher').live 'click', @launch 
    $('.modal .close').click @close
    $('#login .button').click @login
    $('#signup .button').click @signup
    $('#edituser .button').click @edituser
    $('#newplot .button').click @newplot

  launch: (event)=>
    launcher = $ event.currentTarget
    @show launcher.data 'modal-id'
    false

  show:(id)=>
    $("##{id}").show()
    @logout() if id is 'logout'

    @background.show()

  hide:(id)=>
    $("##{id}").hide()
    @background.hide()

  close: (event)=>
    @hide $(event.currentTarget).parent().attr('id')
    false

  login: (event)=>
    button = $ event.currentTarget
    email = button.siblings('.email').val()
    password = button.siblings('.password').val()
    $.post '/login',
      email: email
      password: password
    , @loginResult
    @close event
    no

  logout: (event)=>
    @app.user = no
    @app.loggedin = no
    @close event

  loginResult: (data,status)=>
    if data
      @app.loggedin = yes 
      @app.user = data
      $(@app).trigger 'loggedin'
    else
      @app.loggedin = no
      @app.user = no
      alert 'login failed please try again'
      $(@app).trigger 'loggedout'
      @show 'login'
  
  signup: (event)=>
    button = $ event.currentTarget
    email = button.siblings('.email').val()
    password = button.siblings('.password').val()
    confirm_password = button.siblings('.confirm_password').val()
    if password is confirm_password
      $.post '/signup',
        email: email
        password: password
      , @signupResult
    @close event
    no

  signupResult: (data, status)=>
    if data
      @app.loggedin = yes
      @app.user = data
      $(@app).trigger 'loggedin'
    else
      @app.loggedin = no
      @app.user = no
      alert 'sign up failed'
      $(@app).trigger 'loggedout'

  edituser: (event)=>
    button = $ event.currentTarget

    no
  
  newplot: (event)=>
    if @app.user
      button = $ event.currentTarget
      x = @app.navigator.plot.x
      y = @app.navigator.plot.y
      user_id = @app.user.id
      title = button.siblings('.title').val()
      description = button.siblings('.description').val()
      $.post '/newplot',
        x : x 
        y : y
        user_id : user_id
        title : title
        description : description
      , @newplotResult
    else
      alert 'please log in'
    @close event
    no

  newplotResult: (data, error)=>
    console.log data
    console.log error if error
    alert 'plot made!'

