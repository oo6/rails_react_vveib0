$ ->
  $('#expand-micropost-modal').on('hidden.bs.modal', ->
    $('#expand-micropost-modal .modal-body').empty()
  )
