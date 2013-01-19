class window.Modals
  constructor: (@app)->
    @background = $ '.modal-background'
    @background.hide()
    $('.modal').hide()
    $('.modal-launcher.inline').live 'click', @launch
    $('.modal .close').click @close
    # $('#login .button').click @login
    # $('#signup .button').click @signup
    # $('#edituser .button').click @edituser
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
    href = button.attr('href')
    success = (data)->
      $(@app).trigger 'loggedin', data
    error = (error)->
      console.log error
      $(@app).trigger 'loggedout'
      alert 'login failed please try again'
    data = 
      remote: true
      commit: "Sign in"
      utf8: "✓"
      user: 
        remember_me: 1
        password: password
        email: email
    $.get(href, data).success(success).error(error)
    @close event
    no

  logout: (event)=>
    button = $ event.currentTarget
    $.post button.attr('href')
    , =>
      $(@app).trigger 'loggedout'
      @close event
  
  signup: (event)=>
    button = $ event.currentTarget
    email = button.siblings('.email').val()
    password = button.siblings('.password').val()
    password_confirmation = button.siblings('.password_confirmation').val()
    if password is confirm_password
      $.post button.attr('href'),
        email: email
        password: password
        password_confirmation: password_confirmation
      , @signupResult
    @close event
    no

  signupResult: (data, status)=>
    if data
      @app.loggedin = yes
      @app.user = data
      $(@app).trigger 'loggedin', data
    else
      @app.loggedin = no
      @app.user = no
      alert 'sign up failed'
      $(@app).trigger 'loggedout'

  edituser: (event)=>
    button = $ event.currentTarget
    no
  
  newplot: (event)=>
    if $('.hidden.id').length isnt 0
      button = $ event.currentTarget
      x = @app.navigator.plot.x
      y = @app.navigator.plot.y
      title = button.siblings('.title').val()
      description = button.siblings('.description').val()
      $.post '/plots.json',
        x : x 
        y : y
        title : title
        description : description
      , (data, error)=>
        console.log data if error is 'success'
        $(@app).trigger 'requestPlot', 'nowhere'
    else
      alert 'please log in'
    @close event
    no
