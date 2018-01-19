class Song < ApplicationRecord
  belongs_to :album, optional: true
  has_one :artist, through: :album

  validates :title, presence: :true
  validates :artist, presence: :true
  validates :album, presence: :true
end
