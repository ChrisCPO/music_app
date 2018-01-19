class AddRatingAndReleaseDateToSong < ActiveRecord::Migration[5.1]
  def change
    add_column :songs, :release_date, :date
    add_column :songs, :rating, :integer
  end
end
