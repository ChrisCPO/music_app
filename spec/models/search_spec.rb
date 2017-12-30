require "rails_helper"

describe Search do
  describe "#find" do
    it "returns song matching by title of query" do
      artist = create(:artist, :with_album)
      song = artist.songs.first

      search = Search.new(query: song.title)
      results = search.find

      expect(results.length).to eq 1
    end

    context "search quirks" do
      it "returns song matching query with random spaces" do
        artist = create(:artist, :with_album)
        song = create(:song, title: "foo bar")
        artist.albums.first.songs << song
        query = "    foo     bar "

        search = Search.new(query: query)
        results = search.find

        expect(results.length).to eq 1
      end
    end

    context "album" do
      it "returns songs matching by album title" do
        artist = create(:artist, :with_album)
        album = artist.albums.first

        search = Search.new(query: album.title)
        results = search.find

        expect(results.length).to eq 10
      end
    end

    context "artist" do
      it "returns songs matching by artist first name" do
        artist = create(:artist, :with_album)

        search = Search.new(query: artist.first_name)
        results = search.find

        expect(results.length).to eq 10
      end

      it "returns songs matching by artist last name" do
        artist = create(:artist, :with_album)

        search = Search.new(query: artist.last_name)
        results = search.find

        expect(results.length).to eq 10
      end

      it "returns songs matching by artist full name" do
        artist = create(:artist, :with_album)

        search = Search.new(query: artist.full_name)
        results = search.find

        expect(results.length).to eq 10
      end
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
        artist = create(:artist, :with_album)
        song = create(:song, title: "Dave Mathews Band")
        artist.albums.first.songs << song

        search = Search.new(query: "Mathews")
        results = search.find

        expect(results.length).to eq 1
      end

      context "case insensitive" do
        it "returns matching songs" do
          artist = create(:artist, :with_album)
          song = create(:song, title: "Dave Mathews Band")
          artist.albums.first.songs << song

          search = Search.new(query: "mathews")
          results = search.find

          expect(results.length).to eq 1
        end

        it "returns matching songs" do
          artist = create(:artist, :with_album)
          song = create(:song, title: "Dave Mathews Band")
          artist.albums.first.songs << song

          search = Search.new(query: "MATHEWS")
          results = search.find

          expect(results.length).to eq 1
        end
      end
    end
  end
end
