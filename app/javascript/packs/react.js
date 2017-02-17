// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import 'whatwg-fetch'

import React from 'react'
import { render } from 'react-dom'
import { Router, Route, IndexRoute, browserHistory } from 'react-router'
import { Provider } from 'react-redux'
import { syncHistoryWithStore } from 'react-router-redux'

import configureStore from '../store'
import Application from '../routes/layouts/application'
import Test from '../routes/test'

const store = configureStore()
const history = syncHistoryWithStore(browserHistory, store)

document.addEventListener("DOMContentLoaded", e => {
  render((
    <Provider store={ store }>
      <Router history={ history }>
        <Route path="/react" component={ Application }>
          <IndexRoute component={ Test } />
        </Route>
      </Router>
    </Provider>
  ), document.getElementById('root'))
})
