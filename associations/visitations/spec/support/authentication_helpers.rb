module AuthenticationHelpers
  def sign_in_as!(user)
    visit new_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    expect(page).to have_content('Signed in successfully')
  end
  
  def sign_out!
    click_link 'Sign out'
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelpers, type: :feature
end