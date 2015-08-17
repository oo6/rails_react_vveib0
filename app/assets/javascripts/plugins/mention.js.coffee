$ ->
  data = [
    'tom'
    'john'
  ]

  $('#micropost_content').atwho
    at: '@'
    'data': data
  $('#comment_content').atwho
    at: '@'
    'data': data
