import React, { Component } from 'react';

class SignInButton extends Component {
  constructor(props) {
    super(props);
    this.state = {
      user: this.props.user
    }
  }

  componentDidMount() {
    if (!this.state.user) {
     fetch(`/api/v1/current_user.json`, {
        credentials: 'same-origin',
        method: 'GET',
        headers: { 'Content-Type': 'application/json' }
      })
      .then(response => response.json() )
      .then(body => {
        this.setState({ user: body })
      } )
    }
  }

  render() {
    if (this.state.user) {
      return (
        <a href="/signout">
        <p className="bring-to-front" id="sign_out">Sign out</p>
        </a>
      )
    } else {
      return (
        <a href="/auth/google_oauth2">
        <p className="bring-to-front" id="sign_out">Sign in with Google</p>
        </a>
      )
    }
  }
}

export default SignInButton;
