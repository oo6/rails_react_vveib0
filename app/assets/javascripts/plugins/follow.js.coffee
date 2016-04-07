$(document)
  .on 'mouseenter', '.follow-or-unfollow .btn', ->
    $button = $(this)
    if($button.data('method') == 'delete')
      $button
        .removeClass('btn-success')
        .addClass('btn-danger')
        .text('取消关注')

  .on 'mouseleave', '.follow-or-unfollow .btn', ->
    $button = $(this)
    if($button.data('method') == 'delete')
      $button
        .removeClass('btn-danger')
        .addClass('btn-success')
        .text('正在关注')
