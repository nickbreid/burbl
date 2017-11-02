import React from 'react';

const NoboToggle = props => {

  let handleClick = () => {
    props.toggleNobo()
  }

  return (
    <div className="small-6 medium-3 columns">
      <div className="switch large" onChange={handleClick}>
        <input className="switch-input" id="nobo" type="checkbox" name="nobo"/>
        <label className="switch-paddle" htmlFor="nobo">
          <span className="show-for-sr">Southbound?</span>
          <span className="switch-active" aria-hidden="true">Southbound</span>
          <span className="switch-inactive" aria-hidden="true">Northbound</span>
        </label>
      </div>
    </div>
  )
}

export default NoboToggle;
