class ProjectsController < ApplicationController
  before_action :require_signin!
  
  def index
    @projects = Project.all
  end
end