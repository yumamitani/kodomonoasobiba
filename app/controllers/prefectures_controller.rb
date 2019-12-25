class PrefecturesController < ApplicationController

  def show
    @reviews = Review.where(prefecture_id: params[:id]).order("created_at DESC").page(params[:page]).per(12)
    @prefecture= Prefecture.find(params[:id])

    prefecture_reviews= Review.where(prefecture_id: params[:id])
    prefecture_likes= Like.joins(:review).where(reviews: {prefecture_id: params[:id]})
    ranking_ids= prefecture_likes.group(:review_id).order("count(review_id) DESC").limit(3).pluck(:review_id)

    first_id= ranking_ids[0]
    second_id= ranking_ids[1]
    third_id= ranking_ids[2]

    @first_review= prefecture_reviews.find_by(id: first_id)
    @second_review= prefecture_reviews.find_by(id: second_id)
    @third_review= prefecture_reviews.find_by(id: third_id)
    
    @likes= Like.where(user_id: @current_user.id)
  end

end
