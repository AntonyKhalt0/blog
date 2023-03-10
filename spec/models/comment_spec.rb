# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to :author }
  it { should belong_to :post }

  it { should validate_presence_of :body }
end
