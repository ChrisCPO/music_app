module FactoryHelpers
  module NameGenerator
    def musical_title
      [
        Faker::Science.element + " " + Faker::Ancient.god,
        Faker::StarTrek.specie + " " + Faker::StarWars.planet,
        Faker::Superhero.power,
        Faker::Hipster.words(2).join(" "),
      ].shuffle.first
    end
  end
end
