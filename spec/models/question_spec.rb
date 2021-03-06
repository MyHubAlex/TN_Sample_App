require 'rails_helper'

RSpec.describe Question, type: :model do

  let(:question) { create(:question) }

  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:attachments).dependent(:destroy) }
  it { should have_many(:subscriptions).dependent(:destroy) }
  it { should have_many(:subscribers).through(:subscriptions).source(:user) }

  it { should accept_nested_attributes_for :attachments }
  
  it { should belong_to :user }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  
  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:object) { create(:question, user: user) }


  it_behaves_like 'Votable'


  describe 'subscribe_for_author' do
    subject { build(:question, user: user) }

    it 'should set subscription for author after creating his own question' do
      expect(user).to receive(:subscribe).with(subject)
      subject.save!
    end
  end
end
