import React, { Component } from 'react';
import StopTile from '../components/StopTile.js'
import StopTileLabels from '../components/StopTileLabels.js'
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

  // swap direction from north to south
  toggleNobo() {
    let floatMile = parseFloat(this.state.mile)
    let newMile = (2189.8 - floatMile)
    this.setState({
      nobo: !this.state.nobo,
      mile: newMile.toFixed(1)
     })
  }

  // updates state on MileField change
  handleChange(event) {
    this.setState({ mile: event.target.value })
  }

  // fetch stops data
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

  // if mile or nobo changes, fetch relevant stops data
  componentDidUpdate(prevProps, prevState) {
    if (prevState.mile !== this.state.mile || prevState.nobo !== this.state.nobo) {
      fetch(`/api/v1/stops/?nobo=${this.state.nobo}&mile=${this.state.mile}`, {
        credentials: 'same-origin',
        method: 'GET',
        headers: { 'Content-Type': 'application/json' }
      })
      .then(response => response.json() )
      .then(body => {
        this.setState({ stops: body.data })
        })
      }
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
          <StopTileLabels />
          {parsedStops}
        </ul>
      </div>
    )
  }
}

export default StopsIndexContainer;
