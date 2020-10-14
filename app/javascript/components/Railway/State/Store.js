import { createStore, applyMiddleware, compose } from 'redux';
import thunk from 'redux-thunk';
import { createBrowserHistory } from 'history'
import { routerMiddleware } from 'connected-react-router'

import rootReducer from './Reducers';

const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;

export const createHistory = (props) => createBrowserHistory({
  basename: '/',
})

export const history = createHistory()

const middleware = [
  thunk,
  routerMiddleware(history),
]

export function configureStore(initialState) {
  return createStore(
    rootReducer(history),
    initialState,
    composeEnhancers(
      applyMiddleware(...middleware),
    ),
  );
}
