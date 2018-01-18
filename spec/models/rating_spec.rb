require "rails_helper"

describe Rating do
  context "contestants" do
    describe "::MIN" do
      it "returns min number" do
        expect(Rating::MIN).to eq 1
      end
    end

    describe "::MAX" do
      it "returns max number" do
        expect(Rating::MAX).to eq 5
      end
    end

    describe "::RANGE" do
      it "returns a range of min and max numbers" do
        range = Rating::RANGE

        expect(range.count).to eq 5
        expect(range.first).to eq 1
        expect(range.last).to eq 5
      end
    end
  end
end
