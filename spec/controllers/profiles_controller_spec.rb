# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let(:user) { create(:user) }

  before { login(user) }

  describe "GET #show" do
    before { get :show, params: { id: user } }

    it 'render show view' do
      expect(response).to render_template :show
    end
  end
end
