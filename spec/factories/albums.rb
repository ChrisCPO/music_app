FactoryGirl.define do
  factory :album do
    association :artist
    title { musical_title }
  end
end
