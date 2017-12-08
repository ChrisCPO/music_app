require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe ".Relationships" do
    it { should have_many(:albums) }
    it { should have_many(:songs).through(:albums) }
  end

  describe ".Validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end
end