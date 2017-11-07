import React, { Component } from 'react';
import StopTile from '../components/StopTile'
import SmallStopTile from '../components/SmallStopTile'


class NearestWater extends Component {
  constructor(props) {
    super(props);
    this.state = {
      stop: this.props.stop,
      soboStops: [],
      noboStops: []
    }
  }

  componentDidMount() {
    fetch(`/api/v1/stops/${this.state.stop.id}?query=water`)
    .then(response => response.json() )
    .then(body => {
      this.setState({ soboStops: body.sobo, noboStops: body.nobo })
    })
  }

  render() {

    let noboWaterTiles = this.state.noboStops.map((stop) => {
       return (
        <SmallStopTile
          id={stop.id}
          key={stop.id}
          mileMarker={stop.miles_from_ga}
          name={stop.name}
          tileClass="water"
        />
      )
    })

    let soboWaterTiles = this.state.soboStops.map((stop) => {
       return (
        <SmallStopTile
          id={stop.id}
          key={stop.id}
          mileMarker={stop.miles_from_ga}
          name={stop.name}
          tileClass="water"
        />
      )
    })

    return (
      <div className="row small-tiles">
        <div className="small-12">
          <h2>Water sources</h2>
        </div>
        <div className="small-12 medium-6 right-padding">
          <h4>North</h4>
          <ul>
            {noboWaterTiles}
          </ul>
        </div>
        <div className="small-12 medium-6 right-padding">
          <h4>South</h4>
          <ul>
            {soboWaterTiles}
          </ul>
        </div>
      </div>
    )
  }
}

export default NearestWater;
