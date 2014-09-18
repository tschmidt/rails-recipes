require 'rails_helper'

feature 'Creating a project' do
  let!(:user) { create(:user) }
  
  before do
    sign_in_as!(user)
  end
  
  it 'should be successful with valid attributes' do
    expect do
      click_link 'New Project'
      fill_in 'Name', with: 'My New Project'
      fill_in 'Description', with: 'This is a really awesome project'
      click_button 'Create Project'
    end.to change { Project.count }.by(1)
    expect(page).to have_content('You just created a new project, yay!!')
  end
  
  it 'should fail without a name' do
    expect do
      click_link 'New Project'
      fill_in 'Name', with: ''
      fill_in 'Description', with: 'This is a really awesome project'
      click_button 'Create Project'
    end.to change { Project.count }.by(0)
    expect(page).to have_content(/error/)
    expect(page).to have_content("Name can't be blank")
  end
  
  it 'should fail without a description' do
    expect do
      click_link 'New Project'
      fill_in 'Name', with: 'My New Project'
      fill_in 'Description', with: ''
      click_button 'Create Project'
    end.to change { Project.count }.by(0)
    expect(page).to have_content(/error/)
    expect(page).to have_content("Description can't be blank")
  end
  
  it 'should fail if name already exists' do
    create(:project, name: 'Existing')
    expect do
      click_link 'New Project'
      fill_in 'Name', with: 'Existing'
      fill_in 'Description', with: 'This is a really awesome project'
      click_button 'Create Project'
    end.to change { Project.count }.by(0)
    expect(page).to have_content(/error/)
    expect(page).to have_content('Name has already been taken')
  end
end