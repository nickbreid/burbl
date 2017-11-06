import React, { Component } from 'react';
import StopTile from '../components/StopTile'

class NearestWater extends Component {
  constructor(props) {
    super(props);
    this.state = {
      stop: this.props.stop,
      soboWater: [],
      noboWater: []
    }
  }

  componentDidMount() {
    fetch(`/api/v1/stops/${this.state.stop.id}?mile=${this.state.stop.mile_marker}`)
    .then(response => response.json() )
    .then(body => {
      this.setState({ soboWater: body.sobo_water, noboWater: body.nobo_water })
    })
  }

  render() {

    let noboWaterTiles = this.state.noboWater.map((stop) => {
       return (
        <StopTile
          id={stop.id}
          key={stop.id}
          mileMarker={stop.miles_from_ga}
          name={stop.name}
          stopResources={stop.stop_resources}
        />
      )
    })

    let soboWaterTiles = this.state.soboWater.map((stop) => {
       return (
        <StopTile
          id={stop.id}
          key={stop.id}
          mileMarker={stop.miles_from_k}
          name={stop.name}
          stopResources={stop.stop_resources}
        />
      )
    })

    return (
      <div className="row small-tiles">
        <div className="small-12">
          <h2>Water sources</h2>
          <p>These are the nearest water sources to {this.state.stop.name}.</p>
        </div>
        <div className="small-12 medium-6">
          <h4>Northbound</h4>
          <ul>
            {noboWaterTiles}
          </ul>
        </div>
        <div className="small-12 medium-6">
          <h4>Southbound</h4>
          <ul>
            {soboWaterTiles}
          </ul>
        </div>
      </div>
    )
  }
}

export default NearestWater;
