import React, { Component } from 'react';
import BackButton from '../components/BackButton'
import ShowInfo from '../components/ShowInfo'
import ShowResources from '../components/ShowResources'
import NearestWater from './NearestWater'
import NearestCamps from './NearestCamps'
import CommentsContainer from './CommentsContainer'

class StopsShowContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      stop: {},
      component: '',
      user: {},
      comments: []
    }
    this.handleWater = this.handleWater.bind(this)
    this.handleCamps = this.handleCamps.bind(this)
    // this.handleComments = this.handleComments.bind(this)
    this.addNewComment = this.addNewComment.bind(this)
  }

  componentDidMount() {
    window.scrollTo(0,0);

    let stopId = this.props.params.id;
    fetch(`/api/v1/stops/${stopId}`)
    .then(response => response.json() )
    .then(body => {
      this.setState({ stop: body.data })
    })

    fetch(`/api/v1/comments?stop=${this.props.params.id}`)
    .then(response => response.json() )
    .then(body => this.setState({ comments: body.comments }))

    fetch(`/api/v1/current_user.json`, {
      credentials: 'same-origin',
      method: 'GET',
      headers: { 'Content-Type': 'application/json' }
    })
    .then(response => response.json() )
    .then(body => {
      this.setState({ user: body })
    })
  }

  handleWater() {
    this.setState({ component: <NearestWater stop={this.state.stop}/> })
  }

  handleCamps() {
    this.setState({ component: <NearestCamps stop={this.state.stop}/> })
  }

  // handleComments() {
  //   this.setState({
  //     component: <CommentsContainer
  //       stop={this.state.stop}
  //       username={this.state.user}
  //       addComment={this.addNewComment}
  //       comments={this.state.comments}
  //     />
  //   })
  // }

  addNewComment(formPayload) {
    fetch(`/api/v1/comments`, {
      credentials: 'same-origin',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      method: 'post',
      body: JSON.stringify(formPayload)
    })
    .then(response => response.json())
    .then(body => {
      let newComment = {
        key: body.comment.comment.id,
        id: body.comment.comment.id,
        user: body.comment.user.name,
        title: body.comment.comment.title,
        body: body.comment.comment.body,
        created_at: body.comment.comment_created_at
      }
      this.setState({
        comments: this.state.comments.concat(newComment)
      })
    })
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
              <div className="button" onClick={this.handleComments}>Comment</div>
            </div>
          </div>
        </div>

        <div className="row">
          {this.state.component}
        </div>
        <div className="row">
          <CommentsContainer
            stop={this.state.stop}
            username={this.state.user}
            addComment={this.addNewComment}
            comments={this.state.comments}
          />
        </div>
      </div>
    )
  }
}

export default StopsShowContainer;
