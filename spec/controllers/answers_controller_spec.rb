require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { build(:answer, question: question, user: user) }


  describe "POST #create" do
    sign_in_user

    context "create with valid attributes" do

      it "saves a new answer into the database" do
        expect { post :create, question_id: question, answer: attributes_for(:answer) }.to change(question.answers, :count).by(1)
      end

      it "redirects to question path" do
        post :create, question_id: question, answer: attributes_for(:answer)
        expect(response).to redirect_to assigns(:question)
      end
    end

    context "create with invalid attributes" do

      it "doesn't save a new answer into the database" do
        expect { post :create, question_id: question, answer: attributes_for(:invalid_answer) }.to_not change(Answer, :count)
      end

      it "re-renders new view" do
        post :create, question_id: question, answer: attributes_for(:invalid_answer)
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    sign_in_user

    context 'Update own answer' do

      before { answer.update_attribute(:user, @user) }

      context "update with valid attributes" do

        it "assigns a requested answer to the variable @answer" do
          patch :update, id: answer, answer: attributes_for(:answer)
          expect(response).to redirect_to answer.question
        end

        it "changes attributes question" do
          patch :update, id: answer, answer: { body: "new body" }
          expect(answer.reload.body).to eq "new body"
        end

        it "redirects to updated answer" do
          patch :update, id: answer, answer: attributes_for(:answer)
          expect(response).to redirect_to answer.question
        end
      end

      context "with invalid attributes" do
      
        before do
          patch :update, id: answer, answer: attributes_for(:invalid_answer)
        end

        it "doesn't change attributes" do
          expect(answer.body).to eq "MyText"
        end
      end
    end

    context 'Update other answer' do
      let(:another_user) { create(:user) }
      let(:another_question) { create(:question, user: another_user) }
      let(:another_answer) { create(:answer, question: another_question, user: another_user) }

      it 'cannot update other answer' do
        patch :update, id: another_answer, answer: { body: 'new body' }
        expect(another_answer.body).to eq another_answer.body
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    context 'Delete own answer' do

      before { answer }
      
      it "deletes answer" do
        expect { delete :destroy, id: answer }.to change(Answer, :count).by(-1)
      end

      it "redirects to question show" do
        delete :destroy, id: answer
        expect(response).to redirect_to question_path
      end
    end

    context 'Delete other answer' do
      let(:another_user) { create(:user) }
      let(:another_question) { create(:question, user: another_user) }
      let(:another_answer) { create(:answer, question: another_question, user: another_user) }

      it 'cannot delete other answer' do
        expect { delete :destroy, id: another_answer }.to_not change(Answer, :count)
        expect(response).to redirect_to question_path
      end
    end
  end
end