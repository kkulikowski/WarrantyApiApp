FactoryGirl.define do
  factory :product do
    title { Faker::StarWars.vehicle }
    created_by { Faker::Number.number(10) }
  end
end