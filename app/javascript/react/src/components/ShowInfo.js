import React from 'react';

const ShowInfo = props => {
  let soboMile = parseFloat(2180.8 - props.mile).toFixed(1);
  let townAccess = '';

  if (props.townAccess) {
    townAccess = <h5>Access to: {props.townAccess}</h5>
  }

  return (
    <div>
      <h4 className="mile-label">{props.mile} / <span className="sobo-mile">{soboMile}</span></h4>
      <h1 className="show-info-hed">{props.name}</h1>
      {townAccess}
      <p>{props.description}</p>
      <img className="show-photo" src={props.photo_url}/>
    </div>
  )
}

export default ShowInfo;
