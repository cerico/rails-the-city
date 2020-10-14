import { combineReducers } from 'redux';
import { connectRouter } from 'connected-react-router'
import routerLocations from './RouterLocations'
import cities from './Cities'

export default (history) => combineReducers({
  router: connectRouter(history),
  routerLocations,
  cities,
});
