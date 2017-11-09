import React from 'react';
import { Link } from 'react-router'

const SmallStopTile = props => {

  let soboMileMarker = 2180.8 - props.mileMarker;

  let handleClick = () => {
    props.onClick(props.id);
  }

  // prints a StopTile with extra CSS classes added thru arguments
  let printTile = (mileClass, nameClass) => {
    return (
      <li key={props.mileMarker}>
        <div className="row align-middle stop-tile">
          <div className={`small-3 columns mile-marker align-center ${mileClass}`}>
              <p className="mile-top">{props.distance}</p>
              <p className="mile-bottom">miles away</p>
          </div>
          <div className={`small-9 columns stop-name align-center-left ${nameClass}`}>
            <Link to={`/stops/${props.id}`}>
              <h3 onClick={handleClick}>{props.name}</h3>
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
      printTile("", "camp-tile-name")
    )
  } else {
    return (
      printTile("", "")
    )
  }
}

export default SmallStopTile;
