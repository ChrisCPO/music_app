require 'rails_helper'

RSpec.describe Album, type: :model do
  describe ".Relationships" do
    it { should have_many(:songs) }
    it { should belong_to(:artist) }
  end

  describe ".Validations" do
    it { should validate_presence_of(:title) }
  end
end
