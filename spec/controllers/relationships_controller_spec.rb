# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user, email: "other@test.org" ) }

  before { login(user) }

  describe "POST #create" do
    it "create a new relationship" do
      expect { post :create, params: { followed_id: other_user.id } }.to change(Relationship, :count).by(1)
    end
  end

  describe "DELETE #destroy" do
    let!(:relationship) { create(:relationship, follower_id: user.id, followed_id: other_user.id) }

    it "delete this relationship" do
      expect { delete :destroy, params: { id: relationship.id } }.to change(Relationship, :count).by(-1)
    end
  end
end
