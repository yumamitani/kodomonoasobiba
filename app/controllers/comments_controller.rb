class CommentsController < ApplicationController
  def index
    @review= Review.find(params[:id])
    @comment= Comment.new
    @comments= @review.comments.all
  end

  def create
    @comment= Comment.new(comments_params)
    if @comment.save
      redirect_to("/reviews/#{@comment.review_id}")
    else
      render("/reviews/#{@comment.review_id}/comment")
      flash[:notice]="コメントが投稿できませんでした"
    end
  end

  private
  
  def comments_params
    params.require(:comment).permit(:message, :review_id).merge(user_id: @current_user.id)
  end
end
