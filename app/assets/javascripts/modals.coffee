class window.Modals
  constructor: (@app)->
    @background = $ '.modal-background'
    @background.hide()
    $('.modal').hide()
    $('.modal-launcher').live 'click', @launch 
    $('.modal .close').click @close

  launch: (event)=>
    launcher = $ event.currentTarget
    @show launcher.data 'modal-id'
    false

  show:(id)=>
    $("##{id}").show()
    @background.show()

  hide:(id)=>
    $("##{id}").hide()
    @background.hide()

  close: (event)=>
    @hide $(event.currentTarget).parent().attr('id')
    false

