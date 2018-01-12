require "rails_helper"

feature "User can Search", js: true do
  feature "a user can search for a song" do
    context "nil search produces no results" do
      it "returns a song" do
        song = create(:song, :has_artist)

        visit searches_path

        fill_in "search_query", with: ""
        click_on "Search"

        text = results_text(count: 0, query: "")
        expect(page).to_not have_content text
        expect(page).to_not have_content song.title
        expect(page).to_not have_content song.artist.full_name
        expect(page).to_not have_content song.album.title
      end
    end

    it "returns a song" do
      song = create(:song, :has_artist)
      query = song.title

      visit searches_path
      fill_in "search_query", with: query
      click_on "Search"

      text = results_text(count: 1, query: query)
      expect(page).to have_content text
      expect(page).to have_content song.title
      expect(page).to have_content song.artist.full_name
      expect(page).to have_content song.album.title
    end

    context "forward searching" do
      it "returns searches" do
        title ="cray wolf"
        song = create(:song, :has_artist, title: title)

        visit searches_path
        second_word = title.split(" ")[1]
        fill_in "search_query", with: second_word
        click_on "Search"

        text = results_text(count: 1, query: second_word)
        expect(page).to have_content text
        expect(page).to have_content song.title
      end
    end

    context "user searches from non search page" do
      it "chages url to search index" do
        song = create(:song, :has_artist)
        visit song_path(song)

        fill_in "search_query", with: song.artist.first_name
        click_on "Search"

        expect(current_path).to_not have_text "/songs/#{song.id}"
      end
    end

    context "raw url" do
      it "returns search results of params in url" do
        song = create(:song, :has_artist)
        query = song.title.gsub(" ", "+")

        visit "/searches?&search%5Bquery%5D=#{query}"

        text = results_text(count: 1, query: song.title)
        expect(page).to have_content text
        expect(page).to have_text song.title
      end
    end

    context "search history" do
      context "when a user hits back button to search page" do
        it "returns previous search" do
          song = create(:song, :has_artist)

          visit searches_path
          fill_in "search_query", with: song.title
          click_on "Search"

          click_link song.title
          page.go_back

          text = results_text(count: 1, query: song.title)
          expect(page).to have_content text
          expect(page).to have_text song.title
        end
      end
    end

    context "reverse searching" do
      it "returns searches" do
        title ="cray wolf"
        song = create(:song, :has_artist, title: title)

        visit searches_path
        first_word = title.split(" ")[0]
        fill_in "search_query", with: first_word
        click_on "Search"

        text = results_text(count: 1, query: first_word)
        expect(page).to have_content text
        expect(page).to have_content song.title
      end
    end
  end

  feature "advanced searching options" do
    feature "advanced options available" do
      context "only renders if there was a basic search result" do
        it "does not render advanced options" do
          song = create(:song, :has_artist)

          visit searches_path
          expect(page).to have_field("Release year", visible: false)
          expect(page).to have_field("Rating", visible: false)
        end

        it "renders advanced options" do
          song = create(:song, :has_artist)

          visit searches_path
          fill_in "search_query", with: song.title
          click_on "Search"

          expect(page).to have_field("Release year")
          expect(page).to have_field("Rating")
        end
      end
    end

    feature "search by release date" do
      it "returns songs matching by query and release date" do
        title = "Crazy Cool"
        song_1 = create(:song, :has_artist, title: title)
        song_2 = create(:song, :has_artist, title: title)

        params = { search: { query: song_1.title } }
        visit searches_path(params)

        fill_in "Release year", with: song_1.release_date.year
        click_on "Search"

        text = results_text(count: 1, query: title)
        expect(page).to have_content text
      end
    end
  end

  feature "after searching for a song a user can" do
    feature "view specific results" do
      context "by song title" do
        it "can click link to that song" do
          song = create(:song, :has_artist)
          visit searches_path

          fill_in "search_query", with: song.title
          click_on "Search"

          click_link song.title

          expect(page).to have_content(/#{song.title}/i)
        end

        it "can click link to that album" do
          album = create(:album, :with_artist, :with_songs)
          song = album.songs.first
          visit searches_path

          fill_in "search_query", with: song.title
          click_on "Search"

          click_link album.title

          expect(page).to have_content(/#{album.title}/i)
          album.songs.each do |tune|
            expect(page).to have_content(/#{tune.title}/i)
          end
        end

        it "can click link to that artist" do
          artist = create(:artist, :with_album)
          song = artist.albums.first.songs.first
          visit searches_path

          fill_in "search_query", with: song.title
          click_on "Search"

          click_link artist.full_name

          expect(page).to have_content artist.full_name
          artist.albums.each do |record|
            expect(page).to have_content record.title
          end
        end
      end
    end
  end
end
