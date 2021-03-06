shared_examples_for 'Create comment' do

  context "Authenticated user tries to leave comment with valid attributes" do

    it "increase comment count by 1" do
      expect { post :create, params, format: :json }.to change(object.comments, :count).by(1)
    end
  end

  context "Authenticated user tries to leave comment with invalid attributes" do

    it "doesnt change comment count" do
      expect { post :create, invalid_params, format: :json }.to_not change(Comment, :count)
    end
  end

  context 'PrivatePub' do
    it 'publishes new object' do
      expect(PrivatePub).to receive(:publish_to).with("/questions/#{object.id}/comments", anything)
      post :create, params, format: :json
    end
  end
end


shared_examples_for 'Update comment' do

  it "changes comment attributes" do
    patch :update, id: object_comment, comment: { body: "new body" }, format: :js
    expect(object_comment.reload.body).to eq "new body"
  end
end


shared_examples_for 'Delete comment' do

  context 'Authenticated user' do
              
    it "can delete own comment" do
      expect { delete :destroy, id: object_comment, format: :js }.to change(Comment, :count).by(-1)
    end
  end

  context 'Authenticated user' do

    it 'cannot delete other comment' do
      expect { delete :destroy, id: object_comment2, format: :js }.to_not change(Comment, :count)
    end
  end
end
