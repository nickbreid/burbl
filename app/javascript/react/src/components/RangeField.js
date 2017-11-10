import React from 'react';

const RangeField = props => {

  return (
    <div>
      <div className="input-group plus-minus-input">
        <label id="range-id">
          Range
          <input id="range-field" type="number" placeholder=">5" value={props.range} onChange={props.handleChange}></input>
        </label>
      </div>
    </div>
  )
}

export default RangeField;
