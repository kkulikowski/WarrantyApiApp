FactoryGirl.define do
  factory :warranty do
    name { Faker::StarWars.wookiee_sentence }
  end
end