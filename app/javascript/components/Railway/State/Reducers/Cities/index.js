export default (state = { }, action) => {
  switch (action.type) {
    case 'SET_PAGE_STATE':
      return {
        ...state,
        ...action.data.cities,
      }
    default:
      return state
  }
}
