import React, { Component } from 'react';
import BackButton from '../components/BackButton'
import ShowInfo from '../components/ShowInfo'
import ShowResources from '../components/ShowResources'
import NearestWater from './NearestWater'
import NearestCamps from './NearestCamps'

class StopsShowContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      stop: {},
      component: ''
    }
    this.handleWater = this.handleWater.bind(this)
    this.handleCamps = this.handleCamps.bind(this)
  }

  componentDidMount() {
    let stopId = this.props.params.id;
    fetch(`/api/v1/stops/${stopId}`, {
      credentials: 'same-origin',
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    })
    .then(response => response.json() )
    .then(body => {
      this.setState({ stop: body.data })
    })
  }

  handleWater() {
    this.setState({ component: <NearestWater stop={this.state.stop}/> })
  }

  handleCamps() {
    this.setState({ component: <NearestCamps stop={this.state.stop}/> })
  }


  render() {
    return (
      <div className="grid-container">
        <BackButton />
        <div className="show-container">
          <div className="row">
            <div className="small-12 medium-6 columns show-div">
              <ShowInfo
                mile={this.state.stop.mile_marker}
                name={this.state.stop.name}
                description={this.state.stop.description}
                photo_url={this.state.stop.photo_url}
              />
            </div>
            <div className="small-12 medium-3 columns resources-div">
              <h5>Resources</h5>
              <ShowResources
                stopResources={this.state.stop.stop_resources}
                lineBreak="</br>"
                ulClass=""
              />

            </div>
            <div className="small-12 medium-3 columns show-functions-div">
              <h5>Find the nearest water sources</h5>
              <div className="button" onClick={this.handleWater}>Water</div>
              <h5>Find the nearest campsites</h5>
              <div className="button" onClick={this.handleCamps}>Campsites</div>
              <h5>Add a comment about {this.state.stop.name}</h5>
              <div className="button">Comment</div>
            </div>
          </div>
        </div>

        <div className="row show-row-2">
          {this.state.component}
        </div>
      </div>
    )
  }
}

export default StopsShowContainer;
