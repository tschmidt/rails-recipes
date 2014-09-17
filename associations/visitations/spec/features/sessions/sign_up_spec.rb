require 'rails_helper'

feature "Sign up" do
  before do
    visit root_path
    click_link "Sign up"
  end
  
  it "creates user with valid attributes" do    
    expect do
      fill_in "Name", with: "Terry Schmidt"
      fill_in "Email", with: "terry@schmidt.com"
      fill_in "Password", with: 'secret'
      click_button "Sign up"
    end.to change{ User.count }.by(1)
    expect(page).to have_content("Congrats! You have successfully signed up.")
  end
  
  it "fails with blank name" do
    expect do
      fill_in "Name", with: ""
      fill_in "Email", with: "terry@schmidt.com"
      fill_in "Password", with: 'secret'
      click_button "Sign up"
    end.to change{ User.count }.by(0)
    expect(page).to have_content(/error/)
    expect(page).to have_content("Name can't be blank")
  end
  
  it "fails with invalid email" do
    expect do
      fill_in "Name", with: "Terry Schmidt"
      fill_in "Email", with: "notanemail"
      fill_in "Password", with: 'secret'
      click_button "Sign up"
    end.to change{ User.count }.by(0)
    expect(page).to have_content(/error/)
    expect(page).to have_content('Email is invalid')
  end
  
  it "fails without a password" do
    expect do
      fill_in "Name", with: "Terry Schmidt"
      fill_in "Email", with: "terry@schmidt.com"
      fill_in "Password", with: ''
      click_button "Sign up"
    end.to change{ User.count }.by(0)
    expect(page).to have_content(/error/)
    expect(page).to have_content("Password can't be blank")
  end
  
  it "fails if email is already taken" do
    create(:user, email: 'terry@schmidt.com')
    expect do
      fill_in "Name", with: "Terry Schmidt"
      fill_in "Email", with: "terry@schmidt.com"
      fill_in "Password", with: 'secret'
      click_button "Sign up"
    end.to change{ User.count }.by(0)
    expect(page).to have_content(/error/)
    expect(page).to have_content('Email has already been taken')
  end
end