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
      console.log(body.data);
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
          id={stop.id}
          key={stop.id}
          mileMarker={stop.mile_marker}
          name={stop.name}
          toNextPoint={stop.to_next_point}
          stopResources={stop.stop_resources}
        />
      )
    })

    let ctBorder, vtBorder;
    if (this.state.nobo == true) {
      ctBorder = 1505.9;
      vtBorder = 1596.3
    } else if (this.state.nobo == false) {
      ctBorder = 683.9;
      vtBorder = 593.5;
    }

    return (
      <div className="grid-container">
        <div className="jumbotron">
          <div className="row">
            <div className="small-12 medium-9 columns">
              <h1>Be resourceful.</h1>
              <p>Plan for what's ahead on the Appalachian Trail. Choose a direction and a mile-marker to find nearby water sources, campsites, parking and more.</p>
            </div>
          </div>
        </div>
        <div className="row align-items-bottom">
          <NoboToggle
            toggleNobo={this.toggleNobo}
          />
          <MileField
            mile={this.state.mile}
            handleChange={this.handleChange}
          />
          <div className="small-6 medium-3 columns">
            <p>MA-CT border: {ctBorder}</p>
          </div>
          <div className="small-6 medium-3 columns">
            <p>MA-VT border: {vtBorder}</p>
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
