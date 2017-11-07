import React from 'react';

const ShowInfo = props => {
  return (
    <div>
      <h4 className="mile-label">{props.mile}</h4>
      <h2 className="show-info-hed">{props.name}</h2>
      <p>{props.description}</p>
      <img className="show-photo" src={props.photo_url}/>
    </div>
  )
}

export default ShowInfo;
