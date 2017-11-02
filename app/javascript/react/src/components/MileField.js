import React from 'react';

const MileField = props => {
  return (
    <div>
      <label>
        Mile
        <input id="mile-field" type="number" placeholder="Mile" value={props.mile} onChange={props.handleChange}></input>
      </label>
    </div>
  )
}

export default MileField;
