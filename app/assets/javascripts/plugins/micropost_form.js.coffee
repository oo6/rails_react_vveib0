characterPrompt = (length, selector) ->
  p = $(selector + ' .characterPrompt')
  button = $(selector + ' .create-micropost')
  max = 140
  if length > max
    p.text '已经到达最大输入字数'
    button.addClass 'disabled'
  else
    ch = max - length
    p.text '还可以输入' + ch + '个字'
    if ch == 140
      button.addClass 'disabled'
    else
      button.removeClass 'disabled'

$(document).on 'keyup', '.micropost-form .micropost_content', ->
  characterPrompt $(this).val().length, '.micropost-form'

$(document).on 'keyup', '.modal-body .micropost_content', ->
  characterPrompt $(this).val().length, '.modal-body'
