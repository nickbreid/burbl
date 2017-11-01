import React, { Component } from 'react';
import StopTile from '../components/StopTile.js'
import MileForm from './MileForm.js'

class StopsIndexContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      stops: []
    }
  }

  componentDidMount() {
    fetch(`/api/v1/stops.json`, {
      credentials: 'same-origin',
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    })
    .then(response => response.json())
    .then(body => {
      console.log(body);
      this.setState({ stops: body.data })
    })
  }

  render() {

    let parsedStops = this.state.stops.map((stop) => {
      return (
        <StopTile
          key={stop.mile_marker}
          mileMarker={stop.mile_marker}
          name={stop.name}
          toNextPoint={stop.to_next_point}
          stopResources={stop.stop_resources}
        />
      )
    })

    return (
      <div className="grid-container">
        <MileForm />
        <ul>
          <li>
            <div className="row align-middle">
              <div className="small-2 columns mile-marker align-center">
                <h3>Mile</h3>
              </div>

              <div className="small-9 columns stop-name">
                <h3>Name</h3>
              </div>

              <div className="small-1 columns to-next-point align-center">
                <p>To next point</p>
              </div>
            </div>
          </li>
          {parsedStops}
        </ul>
      </div>
    )
  }
}

export default StopsIndexContainer;
