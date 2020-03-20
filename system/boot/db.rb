# frozen_string_literal: true

Application.boot(:db) do |app|
  start do
    require 'sequel'

    register('db', Sequel.connect(ENV.fetch('DATABASE_URL'), logger: app[:logger]))
  end

  stop do
    db.disconnect
  end
end
