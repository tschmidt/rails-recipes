class SessionsController < ApplicationController
  def new
    redirect_to projects_path if current_user
  end
  
  def create
    user = User.where(email: params[:session][:email]).first
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to projects_url, notice: 'Signed in successfully'
    else
      flash.now[:error] = 'Email or password is incorrect. Please try again.'
      render action: :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'You signed out'
  end
end