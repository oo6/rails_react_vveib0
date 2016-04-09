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

uploadPrompt = (size_in_megabytes) ->
  if size_in_megabytes > 5
    swal({
      title: "Maximum file size is 5MB. Please choose a smaller file.",
      type: "warning"
    })
    return true

uploadImage = (selector, file) ->
  if uploadPrompt(file.size/1024/1024)
    return false
  else
    $("#{ selector } .create-micropost").removeClass('disabled')

    formData = new FormData()
    formData.append('token', $("#{ selector } #qiniu_upload_token").val())
    formData.append('file', file)

    $.ajax({
      url: 'http://upload.qiniu.com',
      type: "POST",
      processData: false,
      contentType: false,
      data: formData,
      success: (data) ->
        pictures = $("#{ selector } #pictures").val()
        if pictures.indexOf(data.key) > -1
          return swal({
            title: "上传图片重复，请重新选择！",
            type: "warning"
          })

        if(!$("#{ selector } .micropost_content").val())
          $("#{ selector } .micropost_content").val('分享图片')

        $("#{ selector } #pictures").val(pictures + data.key + ' ')

        imgUrl = "http://7xrh5z.com1.z0.glb.clouddn.com/#{ data.key }/small"
        $(selector).append("<img src='#{ imgUrl }' />")
    })

$(document)
  .on 'keyup', '.micropost-form .micropost_content', ->
    characterPrompt $(this).val().length, '.micropost-form'

  .on 'keyup', '.modal-body .micropost_content', ->
    characterPrompt $(this).val().length, '.modal-body'

  .on 'change', '.micropost-form .micropost_picture', ->
    uploadImage('.micropost-form', this.files[0])

  .on 'change', '.modal-body .micropost_picture', ->
    uploadImage('.modal-body', this.files[0])

  # .on 'click', '.micropost-form .create-micropost', (e) ->
  #   e.preventDefault()
