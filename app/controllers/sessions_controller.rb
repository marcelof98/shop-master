class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to users_path, notice: 'You are already logged!'
    else
      @user = User.new
    end
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to users_path, notice: 'Logged In!'
    else
        redirect_to login_path, notice: 'campos em branco'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged Out!'
  end
end
