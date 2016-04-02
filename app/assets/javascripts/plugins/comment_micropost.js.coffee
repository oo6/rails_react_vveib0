$(document)
  .on 'click', '.comment-micropost', (e) ->
    micropostId = $(this).data('micropost-id')
    if(!$(this).data('remote'))
      e.preventDefault()

      $(this).data('remote', true)
      $('#micropost-' + micropostId + '-comments')
        .addClass('hide')
        .empty()
    else
      $(this).data('remote', false)
      $('#micropost-' + micropostId + '-comments')
        .removeClass('hide')
        .append('<div class="loader-inner line-scale-pulse-out-rapid"></div>')
      $('.loader-inner').loaders()
