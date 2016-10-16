require 'rails_helper'

RSpec.describe Answer, type: :model do

  it { should belong_to :question }
  it { should belong_to :user }
  it { should validate_presence_of :question_id }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :body }

  it { should have_many(:attachments).dependent(:destroy) }
  it { should accept_nested_attributes_for :attachments }

  it { should have_many(:votes).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }

  
  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer1) { create(:answer, question: question, user: user, best: false) }
  let!(:answer2) { create(:answer, question: question, user: user, best: true) }
  let!(:object) { create(:answer, question: question, user: user) }


  it_behaves_like 'Votable'


  describe 'default_scope' do

    it "should to place the best-answer in the top of list" do
      expect(Answer.first).to eq answer2
    end
  end


  describe 'set_best' do
    
    it "should assign best-answer to true" do
      answer1.set_best
      expect(answer1).to be_best
    end

    it "should assign old best-answer to false" do
      answer2.set_best
      expect(answer1).to_not be_best
    end
  end


  describe 'votes_count' do

    it "should return a count of votes" do
      expect(answer1.votes_count).to eq (0)
    end
  end
end
