module FactoryHelpers
  module DateHelpers
    def new_release_date(rand: true, years_ago: 100)
      if rand
        rand(years_ago.years).seconds.ago
      end
    end
  end
end
