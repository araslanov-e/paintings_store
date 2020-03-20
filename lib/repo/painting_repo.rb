# frozen_string_literal: true

require 'import'

module Repo
  class PaintingRepo
    include Import['db']

    def all
      _table.all
    end

    private

    def _table
      db[:paintings]
    end
  end
end
