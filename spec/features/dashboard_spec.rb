require "rails_helper"

feature "Dashboard root page", js: true do
  feature "trending artists" do
    it "displays top top 5" do
      artists = create_list(:artist, 5, :with_album)
      visit root_path

      title = I18n.t("dashboards.show.trending.artists.title")
      expect(page).to have_text title
      artists.each do |artist|
        expect(page).to have_link artist.full_name
      end
    end
  end
end
