# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :posts }
  it { should have_many :comments }
  it { should have_many :active_relationships }
  it { should have_many :following }
  it { should have_many :passive_relationships }
  it { should have_many :followers }

  it { should validate_presence_of :nickname }
end
