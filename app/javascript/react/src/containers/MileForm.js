import React, { Component } from 'react';
import NoboToggle from '../components/NoboToggle'

class MileForm extends Component {
  constructor(props) {
    super(props);
    this.state = {
      mile: 1510,
      nobo: true
    }
    this.toggleNobo = this.toggleNobo.bind(this)
  }

  toggleNobo() {
    this.setState({ nobo: !this.state.nobo })
  }

  render() {
    return (
      <div className="row">
        <NoboToggle
          handleClick={this.toggleNobo}
        />
      </div>
    )
  }
}

export default MileForm;
