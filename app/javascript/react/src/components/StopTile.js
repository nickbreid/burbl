import React from 'react';

const StopTile = props => {

  let parsedResources, lastLocation, distDir;

  // if the stop has resources
  if (props.stopResources) {

    // create array parsedResources by looping thru resources
    parsedResources = props.stopResources.map(resource => {

      // note the distance and direction_from_trail, if applicable
      if (resource.distance_from_trail && resource.direction_from_trail) {
        distDir = `${resource.direction_from_trail}-${resource.distance_from_trail}m`;

        // don't output distDir if it's same as previous item
        if (distDir !== lastLocation) {
          lastLocation = distDir;
        } else {
          distDir = '';
        }
      }

      // if the resource has an icon, display it
      if (resource.resource_icon) {
        function createMarkup() {
          if (distDir !== undefined) {
            return {__html: `${distDir} ${resource.resource_icon}`};
          } else {
            return {__html: resource.resource_icon}
          }

        }
        return (
          <li key={resource.id} dangerouslySetInnerHTML={createMarkup()} />
        )
      } else {
        // if the resource doesn't have an icon, display its name
        return (
          <div>
            <li key={resource.id}>{resource.resource}</li>
          </div>
        )
      }
    })
  }

  return (
    <li key={props.mileMarker}>
      <div className="row align-middle">
        <div className="small-2 columns mile-marker align-center">
          <h3>{props.mileMarker}</h3>
        </div>

        <div className="small-9 columns stop-name">
            <h3>{props.name}</h3>
          <ul className="menu">
            {parsedResources}
          </ul>
        </div>

        <div className="small-1 columns to-next-point align-center">
          <p>{props.toNextPoint}m</p>
        </div>
      </div>
    </li>

  )
}

export default StopTile;
