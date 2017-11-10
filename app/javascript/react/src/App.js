import React from 'react';
import { Router, browserHistory, Route, IndexRoute } from 'react-router';

import StopsIndexContainer from './containers/StopsIndexContainer'
import StopsShowContainer from './containers/StopsShowContainer'
import NavBar from './containers/NavBar'

const routes = (
  <Route path='/' component={NavBar}>
    <IndexRoute component={StopsIndexContainer}/>
    <Route path='/stops' component={StopsIndexContainer} />
    <Route path='/stops/:id' component={StopsShowContainer} />
  </Route>
)

function hashLinkScroll() {
  const { hash } = window.location;
  if (hash !== '') {
    // Push onto callback queue so it runs after the DOM is updated,
    // this is required when navigating from a different page so that
    // the element is rendered on the page before trying to getElementById.
    setTimeout(() => {
      const id = hash.replace('#', '');
      const element = document.getElementById(id);
      if (element) element.scrollIntoView(true);
    }, 0);
  }
}

const App = props => {
  return(
    <Router
      history={browserHistory}
      routes={routes}
      onUpdate={hashLinkScroll}
    />
  )
}

export default App
