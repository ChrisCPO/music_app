require "rails_helper"

describe Search do
  describe "#find" do
    it "returns songs matching by title of query" do
      song = create(:song)

      search = Search.new(query: song.title)
      results = search.find

      expect(results.length).to eq 1
    end

    context "query is empty" do
      it "returns nothing" do
        song = create(:song)

        search = Search.new(query: "")
        results = search.find

        expect(results.length).to eq 0
      end
    end

    context "titles are similar to query" do
      it "returns matching songs" do
        song = create(:song, title: "Dave Mathews Band")

        search = Search.new(query: "Mathews")
        results = search.find

        expect(results.length).to eq 1
      end

      context "case insensitive" do
        it "returns matching songs" do
          song = create(:song, title: "Dave Mathews Band")

          search = Search.new(query: "mathews")
          results = search.find

          expect(results.length).to eq 1
        end

        it "returns matching songs" do
          song = create(:song, title: "Dave Mathews Band")

          search = Search.new(query: "MATHEWS")
          results = search.find

          expect(results.length).to eq 1
        end
      end
    end
  end
end
