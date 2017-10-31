import React from 'react';


const StopTile = props => {

  let iconConverter = (resource) => {
  }

  let parsedResources;
  if (props.stopResources) {
    parsedResources = props.stopResources.map(resource => {
      if (resource.resource_icon) {
        function createMarkup() {
          return {__html: resource.resource_icon};
        }
        return (
          <li key={resource.id} dangerouslySetInnerHTML={createMarkup()} />
        )
      } else {
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

        <div className="small-8 columns stop-name">
            <h3>{props.name}</h3>
          <ul className="menu">
            {parsedResources}
          </ul>
        </div>

        <div className="small-2 columns to-next-point align-center">
          <p>{props.toNextPoint}</p>
        </div>
      </div>
    </li>

  )
}

export default StopTile;
