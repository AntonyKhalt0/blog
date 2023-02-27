# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:user_post) { create(:post, author: user) }
  let(:comment) { create(:comment, author: user, post: post) }

  before { login(user) }

  describe 'GET #index' do
    let(:posts) { create_list(:post, 3, author: user) }

    before { get :index }

    it 'populates an array of all posts' do
      expect(assigns(:posts)).to match_array(posts)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: user_post } }

    it 'render show view' do
      expect(response).to render_template :show
    end

    it 'assigns a new comment to post' do
      expect(assigns(:comment)).to be_a_new(Comment)
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: user_post } }

    it 'render edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new post in the database' do
        expect { post :create, params: { post: attributes_for(:post) } }.to change(Post, :count).by(1)
      end

      it 'resirects to show view' do
        post :create, params: { post: attributes_for(:post) }
        expect(response).to redirect_to assigns(:post)
      end
    end

    context 'with invalid attributes' do
      it 'does not save post' do
        expect do
          post :create, params: { post: attributes_for(:post, :invalid) }
        end.to_not change(Post, :count)
      end

      it 're-renders new view' do
        post :create, params: { post: attributes_for(:post, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST #update' do
    context 'with valid attributes' do
      it 'assigns the request post to @post' do
        patch :update, params: { id: user_post, post: attributes_for(:post) }
        expect(assigns(:post)).to eq user_post
      end

      it 'changes post attributes' do
        patch :update, params: { id: user_post, post: { title: 'new title', description: 'new body' } }
        user_post.reload

        expect(user_post.title).to eq 'new title'
        expect(user_post.description).to eq 'new body'
      end

      it 'resirects to updated post' do
        patch :update, params: { id: user_post, post: attributes_for(:post) }
        expect(response).to redirect_to user_post
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: user_post, post: attributes_for(:post, :invalid) } }

      it 'does not change post' do
        user_post.reload

        expect(user_post.title).to eq 'Title'
        expect(user_post.description).to eq 'Description'
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user_post) { create(:post, author: user) }

    it 'deletes the post' do
      expect { delete :destroy, params: { id: user_post } }.to change(Post, :count).by(-1)
    end

    it 'redirects to index' do
      delete :destroy, params: { id: user_post }
      expect(response).to redirect_to posts_path
    end
  end
end
