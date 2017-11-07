import React from 'react';

const CommentForm = props => {
  return (
    <div>
      <h3>Add a comment</h3>
      <input
        type="text"
        onChange={props.handleChange}
        value={props.title}
        placeholder="Title"
        name="title"
        id="title"
      />
      <textarea
        type="textarea"
        onChange={props.handleChange}
        value={props.body}
        placeholder="Body"
        name="body"
        id="body"
        className="input"
        rows="10"
        cols="10"
      />
      <input className="button" type="submit" onClick={props.handleSubmit}/>
    </div>
  )
}

export default CommentForm;
