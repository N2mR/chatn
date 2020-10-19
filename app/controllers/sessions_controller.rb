class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      cookies.signed[:user_id] = user.id
      redirect_to root_url
      flash[:success] = "こんにちは、#{user.name}さん"
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end
  def destroy
    log_out if logged_in?
    cookies.signed[:user_id] = nil
    redirect_to root_url
  end


end
