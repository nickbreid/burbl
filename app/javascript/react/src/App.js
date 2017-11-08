import React from 'react';
import { Router, browserHistory, Route, IndexRoute } from 'react-router';

import StopsIndexContainer from './containers/StopsIndexContainer'
import StopsShowContainer from './containers/StopsShowContainer'
import NavBar from './containers/NavBar'

const App = props => {
  return(
    <Router history={browserHistory}>
      <Route path='/' component={NavBar}>
        <IndexRoute component={StopsIndexContainer}/>
        <Route path='/stops' component={StopsIndexContainer} />
        <Route path='/stops/:id' component={StopsShowContainer} />
      </Route>
    </Router>
  )
}

export default App
