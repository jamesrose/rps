$ ->
  if $("#players li").length == 2
    $('#weapons').show()
    $("#waiting-for-player").hide()

  client = new Faye.Client 'http://localhost:9292/faye'
  pubsub_path = "/games/#{$('#game').data('id')}"

  subscription = client.subscribe pubsub_path, (message) ->
    switch message['type']
      when 'player_connected'
        $('#weapons').show()
        $('#waiting-for-player').hide()
        $('#players').append "<li>#{message['name']}</li>"
      when 'player_moved'
        window.location.reload(true)

  $('#weapons a').click (e) ->
    target = $(e.currentTarget)
    $('#weapons .weapon').removeClass('chosen')
    target.parents('.weapon').addClass('chosen')
    $.post("#{pubsub_path}/add_move", target.data())
    client.publish(pubsub_path, type: 'player_moved')