class AnswersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :load_question, only: [:create]
  before_action :load_answer, only: [:update, :destroy, :best]
  before_action :answer_question, only: [:update, :best]
  include Voted

  respond_to :js

  def create
    respond_with(@answer = @question.answers.create(answer_params.merge(user_id: current_user.id)))
  end

  def update
    if current_user.author_of?(@answer)
      @answer.update(answer_params)
      flash[:notice] = "Your answer successfuly updated."
    else
      flash[:notice] = "Your cannot edit alien answer!"
    end
    redirect_to @answer.question
  end

  def destroy
    if current_user.author_of?(@answer)
      respond_with(@answer.destroy)
    else
      flash[:notice] = "Your cannot delete alien answer!"
    end
  end

  def best
    if current_user.author_of?(@answer.question)
      @answer.set_best
      @answers = @question.answers
    end
  end


  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_question
    @question = @answer.question
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file, :id, :_destroy])
  end
end
