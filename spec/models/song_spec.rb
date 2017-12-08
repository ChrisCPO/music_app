require 'rails_helper'

RSpec.describe Song, type: :model do
  describe ".Relationships" do
    it { should belong_to(:album) }
    it { should have_one(:artist).through(:album) }
  end

  describe ".Validations" do
    it { should validate_presence_of(:title) }
  end
end
