require "rails_helper"

feature "User can Search", js: true do
  feature "a user can search for a song" do
    context "nil search produces no results" do
      it "returns a song" do
        song = create(:song, :has_artist)

        visit searches_path
        fill_in "search_query", with: ""
        click_on "Search"

        t = "searches.show.results_length"
        length_text = I18n.t(t, length: 1, for: "")
        expect(page).to_not have_content length_text
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

      t = "searches.show.results_length"
      length_text = I18n.t(t, length: 1, for: query)
      expect(page).to have_content length_text
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

        t = "searches.show.results_length"
        length_text = I18n.t(t, length: 1, for: second_word)
        expect(page).to have_content length_text
        expect(page).to have_content song.title
      end
    end

    context "raw url" do
      it "returns search results of params in url" do
        song = create(:song, :has_artist)
        query = song.title.gsub(" ", "+")

        visit "/searches?&search%5Bquery%5D=#{query}"

        t = "searches.show.results_length"
        length_text = I18n.t(t, length: 1, for: song.title)
        expect(page).to have_content length_text
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

          t = "searches.show.results_length"
          length_text = I18n.t(t, length: 1, for: song.title)
          expect(page).to have_content length_text
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

        t = "searches.show.results_length"
        length_text = I18n.t(t, length: 1, for: first_word)
        expect(page).to have_content length_text
        expect(page).to have_content song.title
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

          expect(page).to have_content song.title
        end

        it "can click link to that album" do
          album = create(:album, :with_artist, :with_songs)
          song = album.songs.first
          visit searches_path

          fill_in "search_query", with: song.title
          click_on "Search"

          click_link album.title

          expect(page).to have_content album.title
          album.songs.each do |tune|
            expect(page).to have_content tune.title
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
