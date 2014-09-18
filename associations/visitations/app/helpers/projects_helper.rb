module ProjectsHelper
  def project_updates_badge_for(project, user)
    if project.visitations.exists?(user_id: user.id) && updates_since_last_visit(project,user) > 0
      content_tag(:span, updates_since_last_visit(project, user), class: 'badge')
    end
  end
  
  def updates_since_last_visit(project, user)
    last_visited_at = project.visitations.where(user_id: user.id).first.updated_at
    project.notes.where(["created_at > ?", last_visited_at]).count
  end
end