# frozen_string_literal: true

FactoryBot.define do
  factory :deal do
    customer { "#{Faker::Books::Dune.character} #{rand(1000)}" }
    description { Faker::Company.name }
    status { 0 }
    closing_date_probability do
      (Time.zone.today + 30.days).strftime('%d/%m/%Y')
    end
    value { Faker::Commerce.price(range: 500..100_000, as_string: true) }
    user
  end
end
