#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require jquery.atwho

#= require bootstrap/dist/js/bootstrap.min.js
#= require nprogress/nprogress.js
#= require sweetalert/dist/sweetalert.min.js
#= require timeago/jquery.timeago.js
#= require loaders.css/loaders.css.js

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
