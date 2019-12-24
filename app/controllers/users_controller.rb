class UsersController < ApplicationController
  before_action :authenticate_user, {only:[:index, :edit, :update, :show]}
  before_action :forbit_login_user, {only:[ :new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only:[ :edit, :update]}

  def index
    @users= User.all
  end

  def show
    @user= User.find(params[:id])
    @likes= Like.where(user_id: @current_user.id)

    @my_reviews= @user.reviews.limit(8)

    favorite_ids= Like.where(user_id: @current_user.id).pluck(:review_id)
    @favorite_reviews= Review.where(id: favorite_ids).limit(8)
  end

  def myreview
    @user= User.find(params[:id])
    @likes= Like.where(user_id: @current_user.id)
    @my_reviews= @user.reviews
  end

  def favorite
    @user= User.find(params[:id])
    @likes= Like.where(user_id: @current_user.id)
    favorite_ids= Like.where(user_id: @current_user.id).pluck(:review_id)
    @favorite_reviews= Review.where(id: favorite_ids)
  end

  def new
    @user=User.new
  end

  def create
    @user= User.new(users_params)
    if @user.save
      session[:user_id]= @user.id
      flash[:notice]= "ユーザー登録に成功しました"
      redirect_to("/users/#{@user.id}/")
    else
      render("users/new")
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(users_params)
      flash[:notice]= "ユーザー情報の編集に成功しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/#{@user.id}/edit")
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(nickname: params[:nickname], password: params[:password])
    if @user
      session[:user_id]= @user.id
    flash[:notice] = "ログインしました"
    redirect_to("/reviews/index")
    else
      @error_message = "ニックネームもしくはパスワードが間違っています"
      @nickname=params[:nickname]
      @password=params[:password]
      render("users/login_form")

    end
  end

  def logout
    session[:user_id]=nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/")
  end

  def ensure_correct_user
    @user = User.find_by(id: params[:id])
    if @current_user.id != @user.id
      flash[:notice]="権限がありません"
      redirect_to("/reviews/index")
    end
  end

  private
  def users_params
    params.require(:user).permit(:nickname, :password, :image_name)
  end

end
