import React, { Component } from 'react';

import SignInButton from '../components/SignInButton'
import HomeButton from '../components/HomeButton'

class NavBar extends Component {
  constructor(props) {
    super(props);
    this.state = {
      user: {}
    }
  }

  render() {
    if (this.state.user && this.state.user !== {} ) {
      return (
        <div>
          <nav className="top-bar" data-topbar role="navigation">
            <ul className="title-area">
              <li className="name">
                <a href="/stops">
                  <i className="fa fa-map fa-2x" aria-hidden="true"></i>
                </a>
              </li>
            </ul>
            <section className="top-bar-section">

              <ul className="right">
                <li>
                  <SignInButton />
              </li>
            </ul>
          </section>
        </nav>

        {this.props.children}
        </div>
      )
    } else {
      return (
        <div>
          <nav className="top-bar" data-topbar role="navigation">
            <ul className="title-area">
              <li className="name">
                <a href="/stops">
                  <i className="fa fa-map fa-2x" aria-hidden="true"></i>
                </a>
              </li>
            </ul>
            <section className="top-bar-section">

              <ul className="right">
                <li>
                  <SignInButton />
                </li>
              </ul>
            </section>
          </nav>

          {this.props.children}
        </div>

      )
    }
  }
}

export default NavBar;
