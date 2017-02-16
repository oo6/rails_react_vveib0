// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import React from 'react'
import { render } from 'react-dom'
import { Router, Route, IndexRoute, browserHistory } from 'react-router'

import Application from '../routes/layouts/application'
import Login from '../routes/login'

// import '../styles/application.global'

document.addEventListener("DOMContentLoaded", e => {
  render((
    <Router history={ browserHistory }>
      <Route path="/react" component={ Application }>
        <IndexRoute component={ Login } />
      </Route>
    </Router>
  ), document.getElementById('root'))
})
