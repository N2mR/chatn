class SessionsController < ApplicationController
  
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      cookies.signed[:user_id] = user.id
      redirect_to root_url
      flash[:success] = "こんにちは、#{user.name}さん"
    else
      redirect_to login_path, flash:{danger:'メールアドレスとパスワードが一致しません'}
    end
  end

  def destroy
    log_out if logged_in?
    cookies.signed[:user_id] = nil
    redirect_to root_url
  end


end
