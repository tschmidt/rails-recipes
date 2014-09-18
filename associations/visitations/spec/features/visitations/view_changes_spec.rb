require 'rails_helper'

feature 'User visiting a project page' do
  let!(:user)       { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:project)    { create(:project) }
  
  before do
    sign_in_as! user
  end
  
  context 'for the first time' do
    it 'should create a visitation' do
      expect(user.visitations.count).to eq(0)
      visit project_path(project)
      expect(user.reload.visitations.count).to eq(1)
      expect(other_user.visitations.count).to eq(0)
    end
  end
  
  context 'they have visited before' do
    before do
      visit project_path(project)
    end
    
    it 'should not create a new visitation' do
      expect(user.visitations.count).to eq(1)
      visit project_path(project)
      expect(user.visitations.count).to eq(1)
    end
    
    it 'should change the updated_at for the visitation' do
      last_updated_at = user.visitations.where(project_id: project.id).first.updated_at
      visit project_path(project)
      expect(user.reload.visitations.where(project_id: project.id).first.updated_at).to_not eq(last_updated_at)
    end
  end
end

feature 'Listing projects' do
  let!(:user)       { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:project)    { create(:project) }
  
  before do
    sign_in_as! user
    visit project_path(project)
    expect(user.visitations.count).to eq(1)
  end
  
  context 'after user visits but no updates are made' do
    it 'does not display a badge' do
      visit projects_path
      within("#project_#{project.id}") do
        expect(page).to_not have_css('.badge')
      end
    end
  end
  
  context 'after user visits and updates are made' do
    it 'displays a badge with number of updates since last visit' do
      create(:note, user: other_user, project: project)
      visit projects_path
      within("#project_#{project.id}") do
        expect(page).to have_css('.badge')
      end
      
      within("#project_#{project.id} .badge") do
        expect(page).to have_content(1)
      end
    end
    
    it 'clears the badge when the user visits the project again' do
      create(:note, user: other_user, project: project)
      visit projects_path
      within("#project_#{project.id}") do
        expect(page).to have_css('.badge')
      end
      
      within("#project_#{project.id} .badge") do
        expect(page).to have_content(1)
      end
      
      visit project_path(project)
      visit projects_path
      
      within("#project_#{project.id}") do
        expect(page).to_not have_css('.badge')
      end
    end
    
    it 'should mark the updates since last visit' do
      create(:note, user: other_user, project: project)
      visit projects_path
      click_link project.name
      
      expect(page).to have_css('.unseen', count: 1)
    end
  end
end