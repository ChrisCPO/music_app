class Song < ApplicationRecord
  belongs_to :album
  has_one :artist, through: :album

  validates :title, presence: :true
end
