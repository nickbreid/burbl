import React, { Component } from 'react';
import StopTile from '../components/StopTile'
import SmallStopTile from '../components/SmallStopTile'

class NearestCamps extends Component {
  constructor(props) {
    super(props);
    this.state = {
      stop: this.props.stop,
      soboCamps: [],
      noboCamps: []
    }
  }

  componentDidMount() {
    fetch(`/api/v1/stops/${this.state.stop.id}?query=camps`)
    .then(response => response.json() )
    .then(body => {
      this.setState({ soboCamps: body.sobo, noboCamps: body.nobo })
    })
  }

  render() {

    let noboCampTiles = this.state.noboCamps.map((stop) => {
       return (
        <SmallStopTile
          id={stop.id}
          key={stop.id}
          mileMarker={stop.miles_from_ga}
          name={stop.name}
        />
      )
    })

    let soboCampTiles = this.state.soboCamps.map((stop) => {
       return (
        <SmallStopTile
          id={stop.id}
          key={stop.id}
          mileMarker={stop.miles_from_ga}
          name={stop.name}
        />
      )
    })

    return (
      <div className="row small-tiles">
        <div className="small-12">
          <h2>Campsites and shelters</h2>
        </div>
        <div className="small-12 medium-6">
          <h4>North</h4>
          <ul>
            {noboCampTiles}
          </ul>
        </div>
        <div className="small-12 medium-6 left-padding">
          <h4>South</h4>
          <ul>
            {soboCampTiles}
          </ul>
        </div>
      </div>
    )
  }
}

export default NearestCamps;
