import React, { Component } from 'react';
import StopTile from '../components/StopTile.js'
import MileField from '../components/MileField.js'
import NoboToggle from '../components/NoboToggle.js'

class StopsIndexContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      stops: [],
      mile: 1505.9,
      nobo: true
    }
    this.toggleNobo = this.toggleNobo.bind(this)
    this.handleChange = this.handleChange.bind(this)
  }

  toggleNobo() {
    this.setState({ nobo: !this.state.nobo })
  }

  handleChange(event) {
    this.setState({ mile: event.target.value })
    fetch(`/api/v1/stops/?mile=${event.target.value}`, {
      credentials: 'same-origin',
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    })
    .then(response => response.json() )
    .then(body => {

      this.setState({ stops: body.data })
    })
  }

  componentDidMount() {
    fetch(`/api/v1/stops.json`, {
      credentials: 'same-origin',
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    })
    .then(response => response.json())
    .then(body => {
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
        <div className="row">
          <div className="small-3 columns">
            <NoboToggle
              toggleNobo={this.toggleNobo}
            />
            <MileField
              mile={this.state.mile}
              handleChange={this.handleChange}
            />
          </div>
        </div>
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
