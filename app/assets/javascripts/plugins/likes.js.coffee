@Likes =
  updateLike: (subject, id, liked = true) ->
    if liked
      $("#like-for-#{ subject }-#{ id }").addClass('liked').data('method', 'delete')
    else
      $("#like-for-#{ subject }-#{ id }").removeClass('liked').data('method', 'post')
