class ReviewsController < ApplicationController
  before_action :authenticate_user, {only:[:edit, :update, :index,]}
  before_action :ensure_correct_user, {only:[:edit, :update, :destroy, ]}

  def home
  end

  def index
    @reviews = Review.all
  end

  def about
  end

  def new
    @review = Review.new
    @prefectures= Prefecture.all
    @image = @review.images.build
  end

  def create
    @prefectures= Prefecture.all
    @review = Review.new(reviews_params)

    if @review.save
      redirect_to("/")
    else
      render("reviews/new")
    end
  end

  def edit
     @review = Review.find_by(id: params[:id])
     @prefectures= Prefecture.all
  end

  def update
    @review= Review.find(params[:id])
    @prefectures= Prefecture.all
   if @review.update(reviews_params)
    redirect_to("/reviews/#{@review.id}")
    flash[:notice]="編集に成功しました"
   else 
    render("reviews/#{@review.id}/edit")
   end
  end

  def destroy
    @review= Review.find_by(id: params[:id])
   if @review.destroy
    redirect_to("/")
    flash[:notice]= "投稿を削除しました"
   else
    render("reviews/#{@review.id}")
   end
  end

  def show
    @review = Review.find(params[:id])
    @user = User.find(@review.user_id)
    @prefecture = Prefecture.find(@review.prefecture_id)
    @likes_count = Like.where(review_id: @review.id).count
    @comments= @review.comments.where.not(user_id: @review.user.id).order("created_at asc").limit(3)
  end

  private
  def reviews_params
    params.require(:review).permit(
    :prefecture_id, :subject, :text, :movie, :address, images_attributes: [:destroy,:id,:image_url]).merge(user_id:@current_user.id)
  end

  def ensure_correct_user
    @review= Review.find_by(id: params[:id])

    if @current_user.id != @review.user.id
      flash[:notice]="権限がありません"
      redirect_to("/reviews/index")
    end
  end
end
