# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:paintings) do
      primary_key :id
      String :name
      Integer :price
      TrueClass :sold, default: false
    end
  end
end
