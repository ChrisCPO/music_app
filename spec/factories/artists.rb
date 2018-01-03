FactoryGirl.define do
  factory :artist do
    first_name { Faker::Name.first_name  }
    last_name { Faker::Name.last_name  }
  end

  trait :with_album do
    transient do
      album_count 1
    end

    after(:create) do |artist, evalulator|
      create_list(:album, evalulator.album_count, :with_songs, artist: artist)
      artist.reload
    end
  end
end
