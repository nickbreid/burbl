import React, { Component } from 'react';
import StopTile from '../components/StopTile'
import SmallStopTile from '../components/SmallStopTile'


class NearestWater extends Component {
  constructor(props) {
    super(props);
    this.state = {
      stopId: this.props.stopId,
      soboStops: [],
      noboStops: []
    }
  }

  componentWillReceiveProps(nextProps) {
    if (nextProps.stopId !== undefined && nextProps.stopId !== this.props.stopId) {
      console.log("fetching: ", `/api/v1/stops/${nextProps.stopId}?query=water`);
      fetch(`/api/v1/stops/${nextProps.stopId}?query=water`)
      .then(response => response.json() )
      .then(body => {
        this.setState({ soboStops: body.sobo, noboStops: body.nobo })
      })
    }
  }

  render() {

    let distance;

    let noboWaterTiles = this.state.noboStops.map((stop) => {

      distance = Math.abs(this.props.stopMile - stop.miles_from_ga)
       return (
        <SmallStopTile
          id={stop.id}
          key={stop.id}
          mileMarker={stop.miles_from_ga}
          distance={parseFloat(distance).toFixed(1)}
          name={stop.name}
          tileClass="water"
          onClick={this.props.onClick}
        />
      )
    })

    let soboWaterTiles = this.state.soboStops.map((stop) => {
      distance = Math.abs(this.props.stopMile - stop.miles_from_ga)
       return (
        <SmallStopTile
          id={stop.id}
          key={stop.id}
          mileMarker={stop.miles_from_ga}
          distance={parseFloat(distance).toFixed(1)}
          name={stop.name}
          tileClass="water"
          onClick={this.props.onClick}
        />
      )
    })

    return (
      <div className="row small-tiles" id="water">
        <div className="small-12">
          <h2>Nearest water sources</h2>
        </div>
        <div className="small-12 medium-6 right-padding">
          <h4 className="reverse-bar">North</h4>
          <ul>
            {noboWaterTiles}
          </ul>
        </div>
        <div className="small-12 medium-6 right-padding">
          <h4 className="reverse-bar">South</h4>
          <ul>
            {soboWaterTiles}
          </ul>
        </div>
      </div>
    )
  }
}

export default NearestWater;
