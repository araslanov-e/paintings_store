namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] => :dotenv do |t, args|
    require 'sequel/core'
    require_relative '../system/boot'
    
    Sequel.extension :migration
    version = args[:version].to_i if args[:version]
    db = Application['db']
    Sequel::Migrator.run(db, 'db/migrations', target: version)
  end

  desc 'Run seeds'
  task seeds: :dotenv do |t, args|
    require 'sequel'
    require 'sequel/extensions/seed'
    require_relative '../system/boot'

    Sequel::Seed.setup(Application.env)
    Sequel.extension :seed

    db = Application['db']
    Sequel::Seeder.apply(db, 'db/seeds')
  end
end
