class UsersController < ApplicationController
    
  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update, :destory]
  
    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
      @reviews = @user.reviews
      @favourite_movies = @user.favourite_movies
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to @user, notice: "Thanks for Signing Up!"
      else
        render :new
      end
    end

    def edit

    end

    def update
      if @user.update(user_params)
        redirect_to @user, notice: "Account successfully updated!"
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      session[:user_id] = nil
      redirect_to movies_url, alert: "Account successfully deleted!"
    end

    private

    def require_correct_user
      @user = User.find(params[:id])
      redirect_to movies_url unless current_user?(@user)
    end


    def user_params
      params.require(:user).
        permit(:name, :username, :email, :password, :password_confirmation)
    end

end
