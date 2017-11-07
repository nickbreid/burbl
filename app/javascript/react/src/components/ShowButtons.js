import React from 'react';

const ShowButtons = props => {
  return (
    <div className="small-12 medium-3 columns show-functions-div">
      <h5>Find the nearest water sources</h5>
      <a href="#water"><div className="button" >Water</div></a>
      <h5>Find the nearest campsites</h5>
      <a href="#campsites"><div className="button" >Campsites</div></a>
      <h5>Add a comment about {props.stop}</h5>
      <a href="#comments"><div className="button" >Comment</div></a>
    </div>
  )
}

export default ShowButtons;
