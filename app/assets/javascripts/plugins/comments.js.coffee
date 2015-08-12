form_html = """
  <form class="new_comment" id="new_comment" action="" accept-charset="UTF-8" data-remote="true" method="post">
    <input name="utf8" type="hidden" value="✓">
    <input type="hidden" name="authenticity_token" value="">
    <div class="form-group">
      <input class="form-control" type="text" name="comment[content]" id="comment_content">
    </div>
    <input type="submit" name="commit" value="发送" class="btn btn-success" data-disable-with="发送">
  </form>
"""

comments_html = """
  <li id="">
    <div class="col-sm-2">
      <a href=""><img alt="" class="gravatar" src=""></a>
    </div>
    <div class="col-sm-10">
      <a href=""><strong></strong></a> : 
      <span class="content"></span>
      <p class="timestamp">
        <time class='timeago' datetime="" data-behaviors="timeago"></time> 来自 VVeib0
      </p>
    </div>
  </li>
"""

more_comments_html = """
  <a class="more-comments" href="">查看更多评论</a>
"""

$(document)
  .on 'click', '.comment', ->
    display = $(this).attr('display')
    micropost_id = $(this).attr('content')
    class_name = '.micropost-' + micropost_id + '-comments'
    comments = $(class_name)

    if display == 'false'
      $(this).attr('display', 'true')

      $(this).after form_html
      action = '/microposts/' + micropost_id + '/comments'
      $(this).next().attr('action', action)
      $('input[name=authenticity_token]').val($('meta[name=csrf-token]').attr('content'))

      comments.append more_comments_html
      $(class_name + ' .more-comments').attr('href', '/microposts/' + micropost_id)

      url = '/microposts/' + micropost_id + '/get_last_five_comments'
      $.ajax
        url: url
        success: (data) ->
          $.each data, (comment_id, comment) ->
            comments.prepend comments_html
            $(class_name + ' li').first().attr('id', comment_id)

            id = "#" + comment_id
            $(id + ' strong').html(comment['user']['name'])
            $(id + ' .content').html(comment['content'])

            $(id + ' time').attr('datetime', comment['created_at'])
            $(id + ' .timeago').timeago()

            $(id + ' a').attr('href', '/users/' + comment['user']['id'])
            $(id + ' .gravatar').attr('src', comment['user']['portrait_url'])
            $(id + ' .gravatar').attr('alt', comment['user']['name'])
    else
      $(this).attr('display', 'false')
      $(this).next().remove()
      $(class_name).empty()
