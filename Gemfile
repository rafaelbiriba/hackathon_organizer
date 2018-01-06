source "https://rubygems.org"
ruby "2.4.1"

gem "rails", "~> 5.1.4"
gem "puma", "~> 3.7"
gem "bootstrap-sass"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "jquery-rails"
gem "config"
gem "newrelic_rpm"

gem "omniauth-google-oauth2"


group :development, :test do
  gem "coveralls", require: false
  gem "simplecov", require: false
  gem "sqlite3"
  gem "rspec"
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "byebug"
end

group :production do
  #gem "mysql2"
  gem "pg"
end
