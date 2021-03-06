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

    context "results limit" do
      it "limits to 20" do
        query = "foo"
        song = create_list(:song, 25, :has_artist, title: query)

        search = Search.new(query: query)
        results = search.find

        expect(results.length).to eq 20
      end
    end

    context "search quirks" do
      it "returns song matching query with random spaces" do
        song = create(:song, :has_artist, title: "foo bar")
        query = "    foo     bar "

        search = Search.new(query: query)
        results = search.find

        expect(results.length).to eq 1
      end

      it "excapes ' " do
        song = create(:song, :has_artist, title: "90's greatest")
        query = "90's"

        search = Search.new(query: query)
        results = search.find

        expect(results.length).to eq 1
      end

      context "query is full of ' " do
        it "excapes ' " do
          song = create(:song, :has_artist, title: "90's greatest")
          query = "2'00' 90's foo''d"

          search = Search.new(query: query)

          expect{ search.find.first }.not_to raise_error
        end
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
        song = create(:song, :has_artist)

        search = Search.new(query: "")
        results = search.find

        expect(results.length).to eq 0
      end
    end

    context "titles are similar to query" do
      it "returns matching songs" do
        song = create(:song, :has_artist, title: "Dave Mathews Band")

        search = Search.new(query: "Mathews")
        results = search.find

        expect(results.length).to eq 1
      end

      context "case insensitive" do
        it "returns matching songs" do
          song = create(:song, :has_artist, title: "Dave Mathews Band")

          search = Search.new(query: "mathews")
          results = search.find

          expect(results.length).to eq 1
        end

        it "returns matching songs" do
          song = create(:song, :has_artist, title: "Dave Mathews Band")

          search = Search.new(query: "MATHEWS")
          results = search.find

          expect(results.length).to eq 1
        end
      end
    end

    context "with advanced options" do
      context "with release year" do
        it "returns the song with the matching release year" do
          title = "Crazy Cool"
          song_1 = create(:song, :has_artist, title: title)
          song_2 = create(:song, :has_artist, title: title)

          options = {
            query: title,
            advanced_search_options: { release_year: song_1.release_date.year }
          }
          search = Search.new(options)
          results = search.find

          expect(results.first).to eq song_1
        end
      end

      context "with rating" do
        it "returns the song with the matching rating" do
          title = "Crazy Cool"
          song_1 = create(:song, :has_artist, title: title)
          song_2 = create(:song, :has_artist, title: title)

          options = {
            query: title,
            advanced_search_options: { rating: song_1.rating }
          }
          search = Search.new(options)
          results = search.find

          expect(results.first).to eq song_1
        end
      end
    end

    context "with sorted results" do
      context "search by song title" do
        it "returns results in sorted by best match" do
          song_1 = create(:song, :has_artist, title: "bar")
          song_2 = create(:song, :has_artist, title: "a fooman")
          song_3 = create(:song, :has_artist, title: "foo")
          song_4 = create(:song, :has_artist, title: "chickenfoo")

          options = {
            query: "foo",
          }
          search = Search.new(options)
          results = search.find

          expect(results.first).to eq song_3
        end
      end
    end
  end

  describe "#results?" do
    it "returns false if there are no results" do
      search = Search.new

      expect(search.results?).to eq false
    end

    it "returns false if there are no results" do
      search = Search.new
      allow(search).to receive(:find_results) { [:song] }

      search.find

      expect(search.results?).to eq true
    end
  end

  describe "#decorate_results" do
    it "decorates the results" do
      song = create(:song, :has_artist)

      options = {
        query: song.title,
      }
      search = Search.new(options)
      search.find
      results = search.decorate_results

      expect(results.first).to eq song
      expect(results.first.released_year).to eq song.decorate.released_year
    end
  end
end
