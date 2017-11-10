import React, { Component } from 'react';

import StopTile from '../components/StopTile.js'
import StopTileLabels from '../components/StopTileLabels.js'
import MileField from '../components/MileField.js'
import NoboToggle from '../components/NoboToggle.js'
import RangeField from '../components/RangeField.js'
import SignInButton from '../components/SignInButton.js'
import Footer from '../components/Footer.js'

class StopsIndexContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      stops: [],
      mile: 1505.9,
      nobo: true,
      prevStop: {},
      thisStop: {},
      range: 5,
      errors: ''
    }
    this.toggleNobo = this.toggleNobo.bind(this)
    this.handleChange = this.handleChange.bind(this)
    this.handlePlus = this.handlePlus.bind(this)
    this.handleMinus = this.handleMinus.bind(this)
    this.validateMile = this.validateMile.bind(this)
    this.handleRange = this.handleRange.bind(this)
  }

  // swap direction from north to south
  toggleNobo() {
    let newMile = (2189.8 - this.state.mile)
    this.setState({
      nobo: !this.state.nobo,
      mile: parseFloat(newMile.toFixed(1))
     })
  }

  // updates state on MileField change
  handleChange(event) {
    let newMile = parseFloat(event.target.value);
    this.validateMile(newMile, this.state.nobo);
    this.setState({ mile: newMile })
  }

  // updates state on RangeField change
  handleRange(event) {
    let newRange = event.target.value
    this.setState({ range: newRange })
  }


  // button pushed to increase mile by 1
  handlePlus() {
    let milePlusOne = parseFloat(this.state.mile)+1
    let newMile = milePlusOne.toFixed(1)
    if (this.validateMile(newMile, this.state.nobo) && !this.state.errors) {
      this.setState({ mile: parseFloat(milePlusOne.toFixed(1))
      })
    }
  }

  // button pushed to decrease mile by 1
  handleMinus() {
    let mileMinusOne = parseFloat(this.state.mile)-1
    let newMile = mileMinusOne.toFixed(1)
    if (this.validateMile(newMile, this.state.nobo) && !this.state.errors) {
      this.setState({ mile: parseFloat(mileMinusOne.toFixed(1))
      })
    }
  }

  // check that mile is in valid nobo or sobo range -- if not, add to error state
  // and return false
  validateMile(mile, directionIsNobo) {
    if (directionIsNobo == true && mile < 1505.9) {
      let newError = "For northbounders, any mile less than 1505.9 is south of Massachusetts. Please enter a valid mile marker.";
      this.setState({
        errors: newError,
        mile: 1505.9
       });
      return false;
    } else if (directionIsNobo == true && mile > 1596.3) {
      let newError = "For northbounders, any mile greater than 1596.3 is north of Massachusetts. Please enter a valid mile marker.";
      this.setState({
        errors: newError,
        mile: 1596.3
       });
      return false;
    } else if (directionIsNobo == false && mile > 683.9) {
      let newError = "For southbounders, any mile greater than 683.9 is south of Massachusetts. Please enter a valid mile marker.";
      this.setState({
        errors: newError,
        mile: 683.9
       });
      return false;
    } else if (directionIsNobo == false && mile < 593.5) {
      let newError = "For southbounders, any mile less than 593.5 is north of Massachusetts. Please enter a valid mile marker.";
      this.setState({
        errors: newError,
        mile: 593.5
       });
      return false;
    } else {
      this.setState({ errors: '' })
      return true;
    }
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

  // if mile or nobo changes, fetch updated stops data
  componentDidUpdate(prevProps, prevState) {
    if (prevState.mile !== this.state.mile || prevState.nobo !== this.state.nobo || prevState.range !== this.state.range) {
      fetch(`/api/v1/stops/?nobo=${this.state.nobo}&mile=${this.state.mile}&range=${this.state.range}`, {
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
    // turn fetched stops data into StopTile components
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
          stopResources={stop.stop_resources}
          prevStop={prevStop}
          thisStop={thisStop}
          thisMile={this.state.mile}
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

    let errorDiv;
    if (this.state.errors) {
      errorDiv = <div className="callout alert">{this.state.errors}</div>
    }

    return (
      <div>
        <div className="grid-container">
          <div className="jumbotron">
            <div className="row">
              <div className="small-12 medium-9 columns">
                <h1>Be resourceful.</h1>
                <h2>Find water sources, campsites, parking and more along the Appalachian Trail.</h2>
              </div>
            </div>
          </div>
          <div id="stops-container">
            <div className="row">
              <div className="small-12 columns">
                <p className="intro">Choose a direction and mile-marker. The limits within Massachusetts are {ctBorder} to {vtBorder}.</p>
                {errorDiv}
              </div>
              <div className="flex-container">
                <NoboToggle
                  toggleNobo={this.toggleNobo}
                />
                <RangeField
                  range={this.state.range}
                  handleChange={this.handleRange}
                />
                <MileField
                  mile={this.state.mile}
                  handleChange={this.handleChange}
                  handlePlus={this.handlePlus}
                  handleMinus={this.handleMinus}
                />
              </div>
            </div>
            <ul>
              <StopTileLabels />
              {parsedStops}
            </ul>
          </div>
          <Footer />
        </div>
      </div>
    )
  }
}

export default StopsIndexContainer;
