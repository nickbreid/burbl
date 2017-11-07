class Api::V1::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    stop = Stop.find(params[:stop])
    comments = stop.comments.order(created_at: :desc)

    returned_comments = comments.map do |comment|
      returned_comment = {
        id: comment.id,
        user: User.find(comment.user_id).name,
        title: comment.title,
        body: comment.body,
        created_at: comment.created_at.strftime("%m/%d/%Y")
      }
    end

    render json: { status: 'SUCCESS', message: 'Loaded comments', comments: returned_comments }, status: :ok
  end

  def create
    comment = current_user.comments.new(comment_params)
    if comment.save
      returned_comment = {
        user: current_user,
        comment: comment,
        comment_created_at: comment.created_at.strftime('%-m/%d/%y')
      }
      render json: { status: 'SUCCESS', message: 'Added comment', comment: returned_comment }, status: :created
    else
      head :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:stop_id, :title, :body)
  end
end
