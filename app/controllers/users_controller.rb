class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  def index
    @user = current_user
    @users = @user.following
    if params[:search]
      @search_user = User.find_by(search_id: "#{params[:search]}")
    end
    
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render 'new'
      flash[:danger] = "faild to create your account"
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end


  def following
  end

  private
    def user_params
      params.require(:user).permit(:name,:email,:search_id,:password,:password_confirmation, :search)
    end
end