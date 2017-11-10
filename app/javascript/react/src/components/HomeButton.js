import React from 'react';
import { browserHistory, Link } from 'react-router'

const HomeButton = props => {
  return(
    <div>
      <Link to={`/stops?mile=${props.mile}&range=5#range-id`}>
        <div className="button">Home</div>
      </Link>
    </div>
  )
}

export default HomeButton;
