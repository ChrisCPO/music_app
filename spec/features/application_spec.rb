require "rails_helper"

feature "General Applicaton", js: true do
  feature "clicking on app title" do
    it "takes a user to root url" do
      song = create(:song, :has_artist)
      visit song_path(song)

      click_link I18n.t("titles.application")

      expect(current_path).not_to have_text song.title
      expect(current_path).to eq "/"
    end
  end
end
