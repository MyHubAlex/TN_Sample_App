require 'rails_helper'

feature 'Sign out', %q{
  In order to sign out
  As an user
  I want to able sign out
} do

  let(:user) { create(:user) }

  scenario 'Authenticated user sign out' do
    sign_in(user)
    visit questions_path
    # pry
    # save_and_open_page
    click_on 'Sign out'

    expect(page).to have_content "Signed out successfully."
    expect(current_path).to eq root_path
  end
end