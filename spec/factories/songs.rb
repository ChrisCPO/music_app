FactoryGirl.define do
  factory :song do
    title { musical_title }
    rating { rand(Rating::RANGE) }
    release_date { new_release_date }
  end

  trait :has_artist do
    before(:create) do |song|
      artist = create(:artist)
      album = create(:album, artist: artist)
      song.album = album
      song.save
    end
  end
end
