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

  describe "#full_name" do
    it "returns combined name" do
      artist = create(:artist)

      full_name = [artist.first_name, artist.last_name].join(" ")

      expect(artist.full_name).to eq full_name
    end
  end

  context "Scopes" do
    describe ".trending" do
      it "returns the 5 artists with highest rating" do
        trending = create_list(:artist, 5,rating: 10)
        create_list(:artist, 5, rating: 5)

        found = Artist.trending

        expect(found.count).to eq 5
        expect(trending - found).to eq []
      end
    end
  end
end
