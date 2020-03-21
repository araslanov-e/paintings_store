desc "Load environment settings from .env.*"
task :dotenv do
  require "dotenv"
  Dotenv.load('.env', ".env.#{ENV.fetch("RACK_ENV", :development)}")
end
