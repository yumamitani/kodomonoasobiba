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
  end

  def create
    @review = Review.new(
      prefecture: reviews_params[:prefecture], 
      subject: reviews_params[:subject], 
      text: reviews_params[:text],
      image: reviews_params[:image],
      movie: reviews_params[:movie],
      user_id: @current_user.id)

    if @review.save
      redirect_to("/")
    else
      render("reviews/new")
    end
  end

  def edit
     @review = Review.find_by(id: params[:id])
  end

  def update
    @review= Review.find_by(id: params[:id])
    @review.prefecture= params[:prefecture]
    @review.subject= params[:subject]
    @review.text= params[:text]
    @review.image= params[:image]
    @review.movie= params[:movie]
   if @review.save
    redirect_to("/show/#{@review.id}")
    flash[:notice]="編集に成功しました"
   else 
    render("reviews/edit")
   end
  end

  def destroy
    @review= Review.find_by(id: params[:id])
    @review.destroy
    redirect_to("/")
  end

  def show
    @id = params[:id]
    @review = Review.find_by(id: params[:id])
    @user = User.find(@review.user_id)
    @likes_count = Like.where(review_id: @review.id).count
  end

  private
  def reviews_params
    params.permit(:prefecture, :subject, :text, :image, :movie )
  end

  def ensure_correct_user
    @review= Review.find_by(id: params[:id])

    if @current_user.id != @review.user.id
      flash[:notice]="権限がありません"
      redirect_to("/reviews/index")
    end
  end
end
