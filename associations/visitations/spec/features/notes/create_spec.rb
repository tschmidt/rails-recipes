require 'rails_helper'

feature 'Create note' do
  let!(:project) { create(:project) }
  let!(:user) { create(:user) }
  
  before do
    sign_in_as! user
    within("#project_#{project.id}") do
      click_link project.name
    end
  end
  
  it 'should succeed with valid attributes' do
    expect do
      click_link 'Add note'
      fill_in 'Content', with: 'I did something...yay!'
      click_button 'Create Note'
    end.to change { project.notes.count }.by(1)
    expect(page).to have_content('Your note was added')
    expect(current_path).to eq(project_path(project))
  end
  
  it 'should fail if content is blank' do
    expect do
      click_link 'Add note'
      fill_in 'Content', with: ''
      click_button 'Create Note'
    end.to change { project.notes.count }.by(0)
    expect(page).to have_content("Content can't be blank")
  end
end