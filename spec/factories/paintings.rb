# frozen_string_literal: true

FactoryBot.define do
  factory :painting, class: Hash do
    skip_create
    initialize_with { attributes.symbolize_keys }

    after(:create) do |hash|
      id = Repo::PaintingRepo.new.send(:_table).insert(hash)
      hash.merge!(id: id)
    end

    name { 'Painting' }
    price { 25 }
    sold { false }
  end
end

