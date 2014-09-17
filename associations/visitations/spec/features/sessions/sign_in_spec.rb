require 'rails_helper'

feature 'Sign in' do
  let!(:user) { create(:user, email: 'terry@schmidt.com', password: 'secret') }
  
  before do
    visit root_path
  end
  
  it 'signs in with valid attributes' do
    fill_in 'Email', with: 'terry@schmidt.com'
    fill_in 'Password', with: 'secret'
    click_button 'Sign in'
    expect(page).to have_content('Signed in successfully')
    expect(current_path).to eq(projects_path)
  end
  
  it 'fails if the email is incorrect' do
    fill_in 'Email', with: 'not@user.com'
    fill_in 'Password', with: 'secret'
    click_button 'Sign in'
    expect(page).to have_content('Email or password is incorrect. Please try again.')
  end
  
  it 'fails if the password is incorrect' do
    fill_in 'Email', with: 'terry@schmidt.com'
    fill_in 'Password', with: 'not the password'
    click_button 'Sign in'
    expect(page).to have_content('Email or password is incorrect. Please try again.')
  end
  
  it 'fails if the email is blank' do
    fill_in 'Email', with: ''
    fill_in 'Password', with: 'secret'
    click_button 'Sign in'
    expect(page).to have_content('Email or password is incorrect. Please try again.')
  end
  
  it 'fails if the password is blank' do
    fill_in 'Email', with: 'terry@schmidt.com'
    fill_in 'Password', with: ''
    click_button 'Sign in'
    expect(page).to have_content('Email or password is incorrect. Please try again.')
  end
end