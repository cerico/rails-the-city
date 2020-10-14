import { combineReducers } from 'redux';

const counter = (state = { counter: { value: 0 }}, action) => {
  switch (action.type) {
    case 'INCREMENT':
      return { ...state, value: action.result.value }
    default:
      return state
  }
}

export default () => combineReducers({
  counter,
});