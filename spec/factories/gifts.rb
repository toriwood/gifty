FactoryGirl.define do
  factory :gift do
    wishlist_id { Faker::Number.number(100) }
    url { Faker::Internet.url }
  end
end 