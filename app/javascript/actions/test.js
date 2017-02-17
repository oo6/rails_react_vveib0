import { ajax } from 'jquery'

export const HI_SUCCESS = 'HI_SUCCESS'
export const HI_FAILURE = 'HI_FAILURE'

function hiSuccess(data) {
  return {
    type: HI_SUCCESS,
    data
  }
}

function hiFailure() {
  return {
    type: HI_FAILURE
  }
}

export function hi() {
  return dispatch => {
    return fetch('http://localhost:5000/api/v2/h')
      .then(response => response.json())
      .then(json => dispatch(hiSuccess(json)))
      .catch(error => {
        dispatch(hiFailure())
        throw error
      })
  }
}
