class Artist < ApplicationRecord
  has_many :albums
  has_many :songs, through: :albums

  validates :first_name, presence: :true
  validates :last_name, presence: :true
end
