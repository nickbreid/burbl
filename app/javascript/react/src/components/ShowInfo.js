import React from 'react';

const ShowInfo = props => {
  return (
    <div>
      <h4 className="mile-label">{props.mile}</h4>
      <h1 className="show-info-hed">{props.name}</h1>
      <p>{props.description}</p>
      <img className="show-photo" src={props.photo_url}/>
    </div>
  )
}

export default ShowInfo;
