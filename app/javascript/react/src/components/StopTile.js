import React from 'react';


const StopTile = props => {

  let parsedResources;
  if (props.stopResources) {
    parsedResources = props.stopResources.map(resource => {
      return (
        <li key={resource.id}>{resource.resource}</li>
      )
    })
  }

  return (
    <li key={props.mileMarker}>
      <h3>{props.mileMarker} - {props.name}</h3>
      <p>To next point: {props.toNextPoint}</p>
      <ul>
        {parsedResources}
      </ul>
    </li>
  )
}

export default StopTile;
