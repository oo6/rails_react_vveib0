$ ->
  data = [
    'tom'
    'john'
  ]

  $('.micropost-form .micropost_content').atwho
    at: '@'
    'data': data

  $('.modal-body .micropost_content').atwho
    at: '@'
    'data': data

  $('#comment_content').atwho
    at: '@'
    'data': data
