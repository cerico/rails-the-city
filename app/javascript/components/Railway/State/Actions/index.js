import { push } from 'connected-react-router'

import constants from '../Constants'
// import * as api from '../../../../actions/api'

export function dataUpdated(data) {
  return {
    type: constants.DATA_UPDATED,
    data,
  }
}

export function setPageState(data) {
  return {
    type: constants.SET_PAGE_STATE,
    data,
  }
}

export function fetchSuccess() {
  return (dispatch) => {
    dispatch({ type: constants.FETCH_SUCCESS })
  }
}

export function fetchFailed(data) {
  return {
    type: constants.FETCH_FAILED,
    data,
  }
}

export function fetchInProgress() {
  return (dispatch) => {
    dispatch({ type: constants.FETCH_IN_PROGRESS })
  }
}

export function postData(id) {
  return async (dispatch) => {
    dispatch(fetchInProgress())
    // const response = await api.postData(id)
    const result = await response.json()
    if (response.status === 200) {
      dispatch(dataUpdated({ ...result }))
    } else {
      console.log('error')
    }
    return response
  }
}
