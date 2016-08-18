require 'rails_helper'

feature "Create answer", %q{
  In order to answer the question
  As an authenticate user
  I want to be able to build answer
} do

  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }

  scenario 'Authenticated user builds answer' do
    sign_in(user)
    visit question_path(question)

    fill_in 'Write your answer:', with: 'Answer text'
    click_on 'Post'

    # save_and_open_page

    expect(page).to have_content "Your answer successfuly posted."
    expect(page).to have_content "Answer text"
    expect(current_path).to eq question_path(question)
  end


  scenario 'Authenticated user builds answer with empty body' do
    sign_in(user)
    visit question_path(question)

    fill_in 'Write your answer:', with: ''
    click_on 'Post'

    expect(current_path).to eq question_answers_path(question)
  end
end