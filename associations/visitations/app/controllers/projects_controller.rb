class ProjectsController < ApplicationController
  before_action :require_signin!
  after_action :visited, only: :show
  before_action :get_last_visited_at, only: :show
  
  def index
    @projects = Project.all
  end
  
  def show
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
  
  def get_last_visited_at
    @project = Project.find(params[:id])
    @last_visited_at = @project.visitations.where(user_id: current_user.id).first.try(:updated_at)
  end
  
  def visited
    if @project.visitations.exists?(user_id: current_user.id)
      @project.visitations.where(user_id: current_user.id).first.touch
    else
      @project.visitations.create(user: current_user)
    end
  end
end