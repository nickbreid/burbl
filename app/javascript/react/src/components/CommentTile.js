import React from 'react';

const CommentTile = props => {
  return (
    <li className="small-12 columns comment-tile">
      <div key={props.id} className="small-4 medium-2 columns comment-user">
        <h3 className="mile-top">{props.username}</h3>
        <img className="profile-pic"/>
      </div>
      <div className="small-8 medium-10 columns comment-body">
        <h4>{props.title} <span className="mile-bottom">{props.createdAt}</span>
</h4>
        <p>{props.body}</p>
      </div>
    </li>
  )
}

export default CommentTile;
