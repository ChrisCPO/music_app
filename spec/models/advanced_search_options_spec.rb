require "rails_helper"

describe Search do
  context "attrbutes" do
    describe "::ATTRS" do
      let(:expected_attrs) {[
        :release_year,
        :rating
      ] }

      it "has the following attributes" do
        attrs = AdvancedSearchOptions::ATTRS

        expect(attrs.length).to eq 2
        expected_attrs.each do |attr|
          expect(attrs).to include attr
        end
      end
    end

    describe "attributes" do
      it "returns a hash of attributes like a AR model" do
        attributes = { release_year: 123, rating: 0 }

        adv_options = AdvancedSearchOptions.new(attributes)
        adv_attrs = adv_options.attributes

        expect(adv_attrs[:release_year]).to eq attributes[:release_year]
        expect(adv_attrs[:rating]).to eq attributes[:rating]
      end
    end

    describe "#has_attributes?" do
      context "has attributes" do
        it "returns true" do
          song = create(:song, :has_artist)

          attrs = { release_year: song.release_date.year }
          adv_options = AdvancedSearchOptions.new(attrs)

          expect(adv_options.has_attributes?).to eq true
        end
      end

      context "does not have attributes" do
        it "returns true" do
          adv_options = AdvancedSearchOptions.new

          expect(adv_options.has_attributes?).to eq false
        end
      end
    end
  end

  describe "#with_queries" do
    context "has attributes" do
      it "returns a sql query appended with queries for attrs" do
        song = create(:song, :has_artist)

        attrs = { release_year: song.release_date.year }
        adv_options = AdvancedSearchOptions.new(attrs)

        results = adv_options.with_queries do
          Song
        end

        expect(results.length).to eq 1
      end
    end
  end
end
