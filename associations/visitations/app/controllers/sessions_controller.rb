class SessionsController < ApplicationController
  def new
    redirect_to projects_path if current_user
  end
end