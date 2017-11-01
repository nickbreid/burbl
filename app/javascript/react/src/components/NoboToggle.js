import React from 'react';


const NoboToggle = props => {
  return (
    <div className="switch large" onClick={props.handleClick}>
      <input className="switch-input" id="nobo" type="checkbox" name="nobo"/>
      <label className="switch-paddle" htmlFor="nobo">
        <span className="show-for-sr">Southbound?</span>
        <span className="switch-active" aria-hidden="true">Southbound</span>
        <span className="switch-inactive" aria-hidden="true">Northbound</span>
      </label>
    </div>
  )
}

export default NoboToggle;
