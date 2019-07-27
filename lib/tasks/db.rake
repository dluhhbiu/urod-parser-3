# frozen_string_literal: true

namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] do |_t, args|
    require 'dotenv'
    require 'sequel'
    Dotenv.load
    Sequel.extension :migration
    version = args[:version].to_i if args[:version]
    Sequel.connect(ENV['DATABASE_URL']) do |db|
      Sequel::Migrator.run(db, 'db/migrations', target: version)
    end
  end
end
