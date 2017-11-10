import React from 'react';

const MileField = props => {

  let plusOne = () => {
    props.handlePlus()
  }

  let minusOne = () => {
    props.handleMinus()
  }

  return (
    <div>
      <div className="input-group plus-minus-input">
        <div className="input-group-button">
          <button type="button" className="button circle" onClick={minusOne}>
            <i className="fa fa-minus" aria-hidden="true"></i>
          </button>
        </div>
          <label>
            Mile
            <input id="mile-field" type="number" placeholder="Mile" value={props.mile} onChange={props.handleChange}></input>
          </label>
          <div className="input-group-button">
            <button type="button" className="button circle" onClick={plusOne}>
              <i className="fa fa-plus" aria-hidden="true"></i>
            </button>
          </div>
      </div>
    </div>
  )
}

export default MileField;
