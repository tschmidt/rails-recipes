class ProjectsController < ApplicationController
  before_action :require_signin!
  after_action :visited, only: :show
  
  def index
    @projects = Project.all
  end
  
  def show
    @project = Project.find(params[:id])
  end
  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to projects_path, notice: 'You just created a new project, yay!!'
    else
      flash.now[:error] = 'Hmm, looks like there might be a problem.'
      render action: :new
    end
  end
  
  private
  
  def project_params
    params.require(:project).permit(:name, :description)
  end
  
  def visited
    if @project.visitations.exists?(user_id: current_user.id)
      @project.visitations.where(user_id: current_user.id).first.touch
    else
      @project.visitations.create(user: current_user)
    end
  end
end