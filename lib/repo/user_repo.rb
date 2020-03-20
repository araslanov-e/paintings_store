# frozen_string_literal: true

require 'import'

module Repo
  class UserRepo
    include Import['db']

    def first
      _table.first
    end

    def find(id)
      _table.where(id: id).first
    end

    private

    def _table
      db[:users]
    end
  end
end

