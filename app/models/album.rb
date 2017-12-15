class Album < ApplicationRecord
  has_many :songs
  belongs_to :artist, optional: true

  validates :title, presence: :true
end
