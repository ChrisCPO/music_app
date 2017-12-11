require "rails_helper"

describe Search do
  describe "#find" do
    it "returns songs matching by title of query" do
      song = create(:song)

      search = Search.new
      results = search.find(song.title)

      expect(results.length).to eq 1
    end

    context "titles are similar to query" do
      it "returns matching songs" do
        song = create(:song, title: "Dave Mathews Band")

        search = Search.new
        results = search.find("Mathews")

        expect(results.length).to eq 1
      end

      context "case insensitive" do
        it "returns matching songs" do
          song = create(:song, title: "Dave Mathews Band")

          search = Search.new
          results = search.find("mathews")

          expect(results.length).to eq 1
        end

        it "returns matching songs" do
          song = create(:song, title: "Dave Mathews Band")

          search = Search.new
          results = search.find("MATHEWS")

          expect(results.length).to eq 1
        end
      end
    end
  end
end
