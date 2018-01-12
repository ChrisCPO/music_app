# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

require "faker"
Dir[Rails.root.join("spec/support/factory_helpers/*.rb")].sort.each { |file| require file }

include FactoryGirl::Syntax::Methods
include FactoryHelpers::NameGenerator
include FactoryHelpers::DateHelpers

50.times do
  rand_num = rand(1..3)
  create(:artist, :with_album, album_count: rand_num)
end
