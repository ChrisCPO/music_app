FactoryGirl.define do
  factory :album do
    title { musical_title }
    rating { rand(Rating::RANGE) }
  end

  trait :with_artist do
    after(:create) do |album|
      artist = create(:artist)
      artist.albums << album
    end
  end

  trait :with_songs do
    after(:create) do |album|
      create_list(:song, 10, album: album)
    end
  end
end
