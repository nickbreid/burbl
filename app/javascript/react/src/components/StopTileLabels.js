import React from 'react';

const StopTileLabels = props => {
// does this need props ^
  return (
    <li>
      <div className="row align-middle">
        <div className="small-3 columns mile-marker align-center">
          <h3>Mile</h3>
        </div>

        <div className="small-9 columns stop-name">
          <h3>Name</h3>
        </div>

      </div>
    </li>
  )
}

export default StopTileLabels;
