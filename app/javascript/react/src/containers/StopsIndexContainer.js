import React, { Component } from 'react';
import StopTile from '../components/StopTile.js'

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
      <div>
        <ul>
          {parsedStops}
        </ul>
      </div>
    )
  }
}

export default StopsIndexContainer;
