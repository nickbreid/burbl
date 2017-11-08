import React from 'react'

const Footer = props => {
  return (
    <div className="row footer expanded">
      <div className="row">
        <div className="small-12 medium-4 footer-box">
          <h5>Burbl</h5>
          <p>A web app designed to help Appalachian Trail thru-hikers plan for what's ahead. Only Massachusetts for now.</p>
          <p><i className="fa fa-copyright" aria-hidden="true"></i> 2017</p>
        </div>
        <div className="small-12 medium-4 footer-box">
          <h5>Nick B. Reid</h5>
          <p>The author of this app, a journalist, a thru-hiker and soon-to-be professional web developer.</p>
          <p>Email him <span className="footer-link"><a href="mailto:nickbreid@gmail.com" target="_top">here</a></span>.</p>
        </div>

        <div className="small-12 medium-4 footer-box">
          <h5>Shout out</h5>
          <p>To the Appalachian Long Distance Hikers Association for collecting the data. And to <span className="footer-link"><a href="https://unsplash.com/@aleskrivec">@AlesKrivec</a></span> for the background photo.</p>
        </div>
      </div>
    </div>
  )
}

export default Footer
