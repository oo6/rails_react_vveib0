import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'

import test from './test'

const reducers = {
  routing: routerReducer,
  test
}

export default combineReducers(reducers)
