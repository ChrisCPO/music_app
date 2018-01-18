class AddRatingToAlbum < ActiveRecord::Migration[5.1]
  def change
    add_column :albums, :rating, :integer
  end
end
