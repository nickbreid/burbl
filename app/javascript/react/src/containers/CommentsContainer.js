import React, { Component } from 'react';
import HomeButton from '../components/HomeButton';
import CommentForm from '../components/CommentForm'
import CommentTile from '../components/CommentTile'


class CommentsContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      stop: this.props.stop,
      user: this.props.user,
      title: '',
      body: ''
    }
    this.handleChange = this.handleChange.bind(this)
    this.clearForm = this.clearForm.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
  }

  handleChange(event) {
    let name = event.target.name;
    let value = event.target.value;
    this.setState({ [event.target.id]: value })
  }

  clearForm() {
    this.setState({
      title: '',
      body: ''
    })
  }

  handleSubmit(event) {
    event.preventDefault()
    let formPayload = ({
      comment: {
        stop_id: parseInt(this.props.stop.id, 10),
        title: this.state.title,
        body: this.state.body
      }
    })
    this.props.addComment(formPayload)
    this.clearForm();
  }

  render() {

    let comments = this.props.comments;
    let parsedComments;


    if (comments.length !== 0) {

      parsedComments = comments.map(comment => {
        return (
          <CommentTile
            key={comment.id}
            id={comment.id}
            username={comment.user}
            body={comment.body}
            title={comment.title}
            createdAt={comment.created_at}
          />
        )
      })
    }


    if (this.props.username !== null && this.props.username !== undefined) {
      return (
        <div className="row small-tiles">
          <div className="small-12 columns" id="comments">
            <div className="small-12 medium-3 columns comment-form">
              <CommentForm
                handleChange={this.handleChange}
                body={this.state.body}
                title={this.state.title}
                handleSubmit={this.handleSubmit}
              />
            </div>
            <div className="small-12 medium-9 columns">
              <h2>Comments</h2>
              <ul className="comments-ul">
                {parsedComments}
              </ul>
            </div>
        </div>
        </div>

      )
    } else {
      return (
        <div className="row small-tiles">
          <div className="small-12 columns" id="comments">
            <div className="small-12 medium-3 columns comment-form">
              <h3>You must sign in to leave a comment.</h3>
            </div>
            <div className="small-12 medium-9 columns comments-ul">
              <h3>Comments</h3>
              <ul className="comments-ul">
                {parsedComments}
              </ul>
            </div>
          </div>
        </div>
      )
    }

  }
}

export default CommentsContainer;
