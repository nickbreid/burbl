import React, { Component } from 'react';
import HomeButton from '../components/HomeButton'
import ShowInfo from '../components/ShowInfo'
import ShowResources from '../components/ShowResources'
import NearestWater from './NearestWater'
import NearestCamps from './NearestCamps'
import CommentsContainer from './CommentsContainer'
import CommentForm from '../components/CommentForm'
import ShowButtons from '../components/ShowButtons'
import SignInButton from '../components/SignInButton'

class StopsShowContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      stop: {},
      user: {},
      comments: [],
      stopId: this.props.params.id
    }

    this.addNewComment = this.addNewComment.bind(this)
    this.changeStop = this.changeStop.bind(this)
    }

  componentDidMount() {
    window.scrollTo(0,0);

    fetch(`/api/v1/stops/${this.props.params.id}`)
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

  componentWillReceiveProps(nextProps) {
    if (this.props.params.id !== nextProps.params.id) {
      this.setState({ stopId: parseInt(nextProps.params.id) })
    }
  }

  changeStop(stopId) {

    fetch(`/api/v1/stops/${stopId}`)
    .then(response => response.json() )
    .then(body => {
      this.setState({ stop: body.data })
    })

    fetch(`/api/v1/comments?stop=${stopId}`)
    .then(response => response.json() )
    .then(body => this.setState({ comments: body.comments }))
  }


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
        <div className="show-container">
          <div className="row">
            <HomeButton mile={this.state.stop.mile_marker} />
          </div>
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
            <ShowButtons
              stop={this.state.stop.name}
            />
          </div>
        </div>
        <NearestWater
          stopId={this.state.stop.id}
          onClick={this.changeStop}
        />
        <NearestCamps
          stopId={this.state.stop.id}
          onClick={this.changeStop}
        />
        <CommentsContainer
          stop={this.state.stop}
          username={this.state.user}
          addComment={this.addNewComment}
          comments={this.state.comments}
        />
      </div>
    )
  }
}

export default StopsShowContainer;
