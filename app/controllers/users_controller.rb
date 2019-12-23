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
  end

  def new
    @user=User.new
  end

  def create
    @user= User.new
    @user.nickname = params[:nickname]
    @user.password =params[:password]
    @user.image_name= "default.jpg"
    if @user.save
      session[:user_id]= @user.id
      flash[:notice]= "ユーザー登録に成功しました"
      redirect_to("/users/#{@user.id}/show")
    else
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.nickname = params[:nickname]
    @user.password =params[:password]
      if params[:image]
        @user.image_name = "#{@user.id}.jpg"
        image= params[:image]
        File.binwrite("public/user_images/#{@user.image_name}", image.read)
      end
    if @user.save
      flash[:notice]= "ユーザー情報の編集に成功しました"
      redirect_to("/users/#{@user.id}/show")
    else
      render("users/edit")
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
end
