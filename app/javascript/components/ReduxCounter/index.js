import React from 'react';
import { Provider } from 'react-redux'
import Counter from './components/Counter'

import { configureStore } from './store'

const Railway = (props) => (
  <Provider store={configureStore(props)}>
     <Counter />
  </Provider>
)

export default Railway
