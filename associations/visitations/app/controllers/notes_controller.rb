class NotesController < ApplicationController
  before_action :require_signin!
  before_action :get_project
  
  def new
    @note = @project.notes.build
  end
  
  def create
    @note = @project.notes.build(note_params)
    @note.user = current_user
    if @note.save
      redirect_to @project, notice: 'Your note was added'
    else
      flash.now[:error] = 'Hmmm, something went wrong'
      render action: :new
    end
  end
  
  private
  
  def get_project
    @project = Project.find(params[:project_id])
  end
  
  def note_params
    params.require(:note).permit(:content)
  end
end