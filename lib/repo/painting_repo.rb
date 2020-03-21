# frozen_string_literal: true

require 'import'

module Repo
  class PaintingRepo
    include Import['db']

    def all
      _table.all
    end

    def find(id)
      _table.where(id: id).first
    end

    def update_attributes(id, params)
      _table.where(id: id).update(params)
    end

    private

    def _table
      db[:paintings]
    end
  end
end
