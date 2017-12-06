FactoryGirl.define do
  factory :song do
    association :artist
    title { musical_title }
  end
end
