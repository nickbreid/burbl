import React, { Component } from 'react';
import StopTile from '../components/StopTile'
import SmallStopTile from '../components/SmallStopTile'

class NearestCamps extends Component {
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
      console.log("fetching: ", `/api/v1/stops/${nextProps.stopId}?query=camps`);
      fetch(`/api/v1/stops/${nextProps.stopId}?query=camps`)
      .then(response => response.json() )
      .then(body => {
        this.setState({ soboStops: body.sobo, noboStops: body.nobo })
      })
    }
  }

  render() {
    let distance;
    let noboCampTiles = this.state.noboStops.map((stop) => {
      distance = Math.abs(this.props.stopMile - stop.miles_from_ga)
       return (
        <SmallStopTile
          id={stop.id}
          key={stop.id}
          mileMarker={stop.miles_from_ga}
          distance={parseFloat(distance).toFixed(1)}
          name={stop.name}
          onClick={this.props.onClick}
        />
      )
    })

    let soboCampTiles = this.state.soboStops.map((stop) => {
      distance = Math.abs(this.props.stopMile - stop.miles_from_ga)
       return (
        <SmallStopTile
          id={stop.id}
          key={stop.id}
          mileMarker={stop.miles_from_ga}
          distance={parseFloat(distance).toFixed(1)}
          name={stop.name}
          onClick={this.props.onClick}
        />
      )
    })

    return (
      <div className="row small-tiles" id="campsites">
        <div className="small-12">
          <h2>Nearest campsites and shelters</h2>
        </div>
        <div className="small-12 medium-6 right-padding">
          <h4 className="reverse-bar">North</h4>
          <ul>
            {noboCampTiles}
          </ul>
        </div>
        <div className="small-12 medium-6 right-padding">
          <h4 className="reverse-bar">South</h4>
          <ul>
            {soboCampTiles}
          </ul>
        </div>
      </div>
    )
  }
}

export default NearestCamps;
