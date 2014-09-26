module ProjectsHelper
  def project_updates_badge_for(project, user)
    last_seen_at = user.visitations.where(project_id: project.id).first.try(:updated_at) || project.created_at
    
    if updates_since_last_visit(project, last_seen_at) > 0
      content_tag(:span, updates_since_last_visit(project, user), class: 'badge')
    end
  end
  
  def updates_since_last_visit(project, last_seen_at)
    project.notes.where(["created_at > ?", last_seen_at]).count
  end
end