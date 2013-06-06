require 'faker'

FactoryGirl.define do
  factory :user, :aliases => [:commenter] do
    sequence(:username) { |n| Faker::Name.name }
    password            "password"
    sequence(:email)    { "#{SecureRandom.uuid}@example.com" }
    factory :admin do
      admin true
    end
  end

  factory :question do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    user
  end

  factory :answer do
    description { Faker::Lorem.paragraph }
    association :answerable, :factory => :question 
    association :user
  end

  factory :vote do
    counter { 1 }
    
  end
end
