import React from 'react';

const StopTileLabels = props => {
// does this need props ^
  return (
    <li>
      <div id="tile-labels" className="row align-items-bottom column-label">
        <div className="small-3 columns column-label-right">
          <p>Mile</p>
        </div>

        <div className="small-9 columns column-label">
          <p>Name</p>
        </div>

      </div>
    </li>
  )
}

export default StopTileLabels;
