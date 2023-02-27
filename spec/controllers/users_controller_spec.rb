# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user, email: "other@test.org") }

  describe "GET #following" do
    before do
      login(user)
      user.follow(other_user)
      get :following
    end

    it "assigns a following users" do
      expect(assigns(:following).first).to eq other_user
    end

    it "render following views" do
      expect(response).to render_template :following
    end
  end

  describe "GET #followers" do
    before do
      login(other_user)
      user.follow(other_user)
      get :followers
    end

    it "assigns a followers users" do
      expect(assigns(:followers).first).to eq user
    end

    it "render followers views" do
      expect(response).to render_template :followers
    end
  end
end
