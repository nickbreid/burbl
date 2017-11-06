import React from 'react';
import { Link } from 'react-router'

const SmallStopTile = props => {

  let soboMileMarker = 2180.8 - props.mileMarker;

  // prints a StopTile with extra CSS classes added thru arguments
  let printTile = (mileClass, nameClass) => {
    return (
      <li key={props.mileMarker}>
        <div className="row align-middle stop-tile">
          <div className={`small-3 columns mile-marker align-center ${mileClass}`}>
              <p className="mile-top">{props.mileMarker}</p>
              <p className="mile-bottom">{soboMileMarker.toFixed(1)}</p>
          </div>
          <div className={`small-9 columns stop-name align-center-left ${nameClass}`}>
            <Link to={`/stops/${props.id}`}>
              <h3>{props.name}</h3>
            </Link>
          </div>
        </div>
      </li>
    )
  }

 if (props.tileClass == "water") {
    return (
      printTile("", "small-water-tile-name")
    )
  } else if (props.tileClass == "camps") {
    return (
      printTile("", "small-camp-tile-name")
    )
  } else {
    return (
      printTile("", "")
    )
  }
}

export default SmallStopTile;
