import React from 'react';
import { browserHistory } from 'react-router'

const BackButton = () => {
  return(
    <div>
      <div className="button" onClick={browserHistory.goBack}>Back</div>
    </div>
  )
}

export default BackButton;
