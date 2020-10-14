import React from 'react';
import { Provider } from 'react-redux'
import { Route, Switch } from 'react-router-dom'
import { ConnectedRouter } from 'connected-react-router'
import Home from './Pages/Home'
import Layout from './Layout'

import { configureStore, history } from './State/Store'

const Railway = (props) => (
  <Provider store={configureStore(props)}>
    <ConnectedRouter history={history}>
      <Layout routes={[]} route={{ appProps: props }}>
        <Switch>
          <Route exact path="/railway" component={Home} />
          <Route path="/" component={Home} />
        </Switch>
      </Layout>
    </ConnectedRouter>
  </Provider>
)

export default Railway
