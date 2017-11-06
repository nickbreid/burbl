import React from 'react';

const ShowResources = props => {

  let parsedResources, lastLocation, distDir;
  let stopResources = props.stopResources;

  // if the stop has resources
  if (stopResources) {

    // create array parsedResources by looping thru resources
    parsedResources = stopResources.map(resource => {

      // note the distance and direction_from_trail, if applicable
      if (resource.distance_from_trail && resource.direction_from_trail) {
        distDir = `${resource.direction_from_trail}-${resource.distance_from_trail}m`;

        // don't output distDir if it's same as previous item. This allows adjacent resources to appear as a group
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
            if (distDir !== '') {
              return {__html: `${distDir}${props.lineBreak} ${resource.resource_icon} - ${resource.resource}`};
            } else {
              return {__html: `${resource.resource_icon} - ${resource.resource}`};
            }

          } else {
            return {__html: `${resource.resource_icon} - ${resource.resource}` }
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
    <ul className={props.ulClass}>
      {parsedResources}
    </ul>
  )
}

export default ShowResources;
