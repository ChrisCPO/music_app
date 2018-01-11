require "rails_helper"

describe Search do
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
