require "rails_helper"

feature "User can Search" do
  feature "a user can search for a song" do
    it "returns a song" do
      song  = create(:song)

      visit new_search_path
      fill_in "search_query", with: song.title
      click_on "Search"

      expect(page).to have_content song.title
    end
  end
end
