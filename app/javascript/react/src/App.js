import React from 'react';
import { Router, browserHistory, Route, IndexRoute } from 'react-router';
import StopsIndexContainer from './containers/StopsIndexContainer'
import StopsShowContainer from './containers/StopsShowContainer'

const App = props => {
  return(
    <Router history={browserHistory}>
      <Route path='/stops'>
        <IndexRoute component={StopsIndexContainer}/>
        <Route path='/stops/:id' component={StopsShowContainer}/>
      </Route>
    </Router>
  )
}

export default App
