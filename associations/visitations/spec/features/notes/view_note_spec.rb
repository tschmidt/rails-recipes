require 'rails_helper'

feature "Viewing notes" do
  let!(:project) { create(:project) }
  let!(:user)    { create(:user) }
  let!(:user2)   { create(:user) }
  let!(:note1)   { create(:note, user: user, project: project) }
  let!(:note2)   { create(:note, user: user2, project: project) }
  
  before do
    sign_in_as! user
    visit project_path(project)
  end
  
  it "displays the notes for the project" do
    expect(page).to have_content(note1.content)
    expect(page).to have_content(note2.content)
  end
  
  it "should display edit links for note owner only" do
    within("#note_#{note1.id}") do
      expect(page).to have_link('Edit')
    end
    
    within("#note_#{note2.id}") do
      expect(page).to_not have_link('Edit')
    end
  end
end