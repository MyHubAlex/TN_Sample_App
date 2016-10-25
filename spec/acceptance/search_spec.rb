require_relative 'acceptance_helper'

feature 'Search', %q{
  In order to search over content 
  As an User
  I want to be able to search over any content
} do

  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }


  scenario 'User can search any content' do
    ThinkingSphinx::Test.run do
      visit root_path
      fill_in 'Search', with: 'q'
      choose :scope, option: 'Question'
      click_on 'Go'

      expect(current_path).to eq search_path
    end
  end
end
