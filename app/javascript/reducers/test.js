import {
  HI_SUCCESS,
  HI_FAILURE
} from '../actions/test'

export default function test(state = {}, action) {
  switch(action.type) {
    case HI_SUCCESS:
      return action.data
    case HI_FAILURE:
      return { text: 'oh, no!' }
    default:
      return state
  }
}
