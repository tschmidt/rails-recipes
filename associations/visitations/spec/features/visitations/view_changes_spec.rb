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