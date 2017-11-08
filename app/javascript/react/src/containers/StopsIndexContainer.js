import React, { Component } from 'react';

import StopTile from '../components/StopTile.js'
import StopTileLabels from '../components/StopTileLabels.js'
import MileField from '../components/MileField.js'
import NoboToggle from '../components/NoboToggle.js'
import SignInButton from '../components/SignInButton.js'

class StopsIndexContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      stops: [],
      mile: 1505.9,
      nobo: true,
      prevStop: {},
      thisStop: {}
    }
    this.toggleNobo = this.toggleNobo.bind(this)
    this.handleChange = this.handleChange.bind(this)
    this.handlePlus = this.handlePlus.bind(this)
    this.handleMinus = this.handleMinus.bind(this)
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

  handlePlus() {
    let milePlusOne = parseFloat(this.state.mile)+1
    this.setState({ mile: milePlusOne.toFixed(1) })
  }

  handleMinus() {
    let mileMinusOne = parseFloat(this.state.mile)-1
    this.setState({ mile: mileMinusOne.toFixed(1) })
  }

  // fetch stops data
  componentDidMount() {
    if (this.props.location.query.mile && this.props.location.query.mile !== this.state.mile) {
      this.setState({ mile: this.props.location.query.mile })
    }

    fetch(`/api/v1/stops.json`, {
      credentials: 'same-origin',
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    })
    .then(response => response.json())
    .then(body => {
      this.setState({
        stops: body.data,
        thisStop: body.this_stop
       })
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
        this.setState({
          stops: body.data,
          prevStop: body.prev_stop,
          thisStop: body.this_stop
         })
        })
      }
    }

  render() {
    let parsedStops = this.state.stops.map((stop) => {
      let prevStop, thisStop;
      if (this.state.prevStop && this.state.prevStop.id == stop.id) {
        prevStop = true;
      } else if (this.state.thisStop && this.state.thisStop.id == stop.id) {
        thisStop = true;
      }
       return (
        <StopTile
          id={stop.id}
          key={stop.id}
          mileMarker={stop.mile_marker}
          name={stop.name}
          toNextPoint={stop.to_next_point}
          stopResources={stop.stop_resources}
          prevStop={prevStop}
          thisStop={thisStop}
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
              <h2>Find water sources, campsites, parking and more along the Appalachian Trail.</h2>
            </div>
          </div>
        </div>
        <div className="stops-container">
          <div className="row input-row align-items-bottom">
            <NoboToggle
              toggleNobo={this.toggleNobo}
            />
            <MileField
              mile={this.state.mile}
              handleChange={this.handleChange}
              handlePlus={this.handlePlus}
              handleMinus={this.handleMinus}
            />
            <div className="small-12 medium-6 columns">
              <p>Choose a direction and mile-marker. The limits within Massachusetts are {ctBorder} to {vtBorder}.</p>
            </div>
          </div>
          <ul>
            <StopTileLabels />
            {parsedStops}
          </ul>
        </div>
      </div>
    )
  }
}

export default StopsIndexContainer;
