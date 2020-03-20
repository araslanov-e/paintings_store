# frozen_string_literal: true

require_relative '../../system/boot'

Sequel.seed(:development) do
  def run
    Application['db'][:users].insert name: 'User', balance: 200

    [
      ['Venice 77', 25],
      ['Palm park', 46],
      ['Atlantis', 130],
      ['Skaftafell', 46],
    ].each do |name, price|
      Application['db'][:paintings].insert name: name, price: price
    end
  end
end
