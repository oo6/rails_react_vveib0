@Microposts =
  insertUserCard: (ele) ->
    console.log $(ele).next().length
    $(ele).after '<div class="loader-inner line-scale-pulse-out-rapid"></div>'
    $('.loader-inner').loaders()
    console.log $(ele).next()

    $.ajax('/users/Example')
      .done((data) ->
        console.log data.email
        $(ele).next().remove()
      ).fail(() ->
        console.log 111
      )

  removeUserCard: (ele) ->
    $(ele).next().hide()
