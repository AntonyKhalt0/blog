# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:user_post) { create(:post, author: user) }
  let(:comment) { create(:comment, author: user, post_id: user_post) }

  before { login(user) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new comment in the database' do
        expect { post :create, params: { comment: attributes_for(:comment), post_id: user_post.id } }.to change(Comment, :count).by(1)
      end

      it 'resirects to show view' do
        post :create, params: { comment: attributes_for(:comment), post_id: user_post.id }
        expect(response).to redirect_to user_post
      end
    end

    context 'with invalid attributes' do
      it 'does not save comment' do
        expect do
          post :create, params: { comment: attributes_for(:comment, :invalid_comment), post_id: user_post.id }
        end.to_not change(Comment, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user_post) { create(:post, author: user) }
    let!(:comment) { create(:comment, author: user, post_id: user_post.id) }

    it 'deletes the comment' do
      expect { delete :destroy, params: { id: comment.id } }.to change(Comment, :count).by(-1)
    end

    it 'redirects to post' do
      delete :destroy, params: { id: comment.id }
      expect(response).to redirect_to user_post
    end
  end
end
