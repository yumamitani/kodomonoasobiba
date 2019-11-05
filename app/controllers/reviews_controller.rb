class ReviewsController < ApplicationController

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
    @review = Review.new(reviews_params)
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
  end

  def saitama
    @reviews = Review.where(prefecture: "埼玉県").order("created_at DESC").page(params[:page]).per(12)
  end

  private
  def reviews_params
    params.permit(:nickname, :prefecture, :subject, :text, :image, :movie)
  end

end
