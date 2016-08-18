require 'rails_helper'

feature "Create question", %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask question
} do

  let(:user) { create(:user) }

  scenario 'Authenticated user creates question' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'
    click_on 'Create'
    # save_and_open_page

    expect(page).to have_content "Your question successfuly created."
    expect(page).to have_content "Test question"
    expect(page).to have_content "text text"
    expect(current_path).to eq question_path(Question.last)
  end

  scenario 'Non-authenticated user ties create question' do
    visit questions_path

    # save_and_open_page

    expect(page).to_not have_link "Ask question"
  end
end