# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: Hash do
    skip_create
    initialize_with { attributes.symbolize_keys }

    after(:create) do |hash|
      id = Repo::UserRepo.new.send(:_table).insert(hash)
      hash.merge!(id: id)
    end

    name { 'User' }
    balance { 200 }
  end
end

