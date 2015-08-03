modify_unread_count = ->
  $.ajax
    url: '/notifications/get_unread_count'
    success: (data) ->
      $('.notifications-count').html data['unread_count']

setInterval (->
  modify_unread_count()
), 2*60*1000
