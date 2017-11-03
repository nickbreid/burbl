import React from 'react';
import { Link } from 'react-router'

const StopTile = props => {

  // prints a StopTile with extra CSS classes added thru arguments
  let printTile = (mileClass, nameClass) => {
    return (
      <li key={props.mileMarker}>
        <div className="row align-middle stop-tile">
          <div className={`small-3 columns mile-marker align-center ${mileClass}`}>
              <h3>{props.mileMarker}</h3>
          </div>
          <div className={`small-9 columns stop-name ${nameClass}`}>
            <Link to={`/stops/${props.id}`}>
              <h3>{props.name}</h3>
            </Link>
            <ul className="menu icon-row">
              {parsedResources}
            </ul>
          </div>
        </div>
      </li>
    )
  }

  let parsedResources, lastLocation, distDir, waterTile, campTile;

  // if the stop has resources
  if (props.stopResources) {

    // create array parsedResources by looping thru resources
    parsedResources = props.stopResources.map(resource => {

      // check if resource is water for tile background
      if (resource.resource == "water") {
        waterTile = true;
      }

      //check if resource is campsite for tile border
      if (resource.resource == "campsites") {
        campTile = true;
      }

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
            <li key={resource.id}>
              {resource.resource}
            </li>
        )
      }
    })
  }

  if (props.prevStop == true) {
    return (
      printTile("prev-stop-mile", "prev-stop-name")
    )
  } else if (props.thisStop == true) {
    return (
      printTile("this-stop-mile", "this-stop-name")
    )
  } else if (waterTile == true && campTile == true) {
    return (
      printTile("", "water-camp-tile-name")
    )
  } else if (waterTile == true) {
    return (
      printTile("", "water-tile-name")
    )
  } else if (campTile == true) {
    return (
      printTile("", "camp-tile-name")
    )
  } else {
    return (
      printTile("", "")
    )
  }
}

export default StopTile;
