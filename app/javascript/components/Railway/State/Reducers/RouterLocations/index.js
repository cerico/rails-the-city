import { LOCATION_CHANGE } from 'connected-react-router'
import qs from 'query-string'

export default (state = { current: null, previous: null, history: [] }, action) => {
  switch (action.type) {
    case LOCATION_CHANGE:
      const { pathname, search, hash } = action.payload.location;
      const current = {
        pathname,
        search,
        hash,
        query: qs.parse(search),
      }
      return {
        current: {
          pathname,
          search,
          hash,
          query: qs.parse(search),
        },
        previous: state.history.length ? state.history[0] : null,
        history: [current, ...state.history],
        step: current.pathname.split('/')[1],
      }
    default:
      return state;
  }
}
