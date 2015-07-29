#= require jquery
#= require jquery_ujs
#= require turbolinks

#= require bootstrap/dist/js/bootstrap.min.js
#= require nprogress/nprogress.js
#= require sweetalert/lib/sweet-alert.min.js
#= require jquery-timeago/jquery.timeago.js
#= require echarts/build/dist/echarts.js

#= require_tree .

$(document).on 'page:update', ->
  $("time[data-behaviors~=timeago]").timeago()

NProgress.configure({ showSpinner: false })
$(document).on 'page:fetch', ->
  NProgress.start()
$(document).on 'page:change', ->
  NProgress.done()
$(document).on 'page:restore', ->
  NProgress.remove()
