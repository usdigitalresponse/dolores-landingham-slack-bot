source "https://rubygems.org"

ruby "2.6.6"
gem "rails", "~> 5.2", ">= 5.2.6"

gem "active_record_union"
gem "acts-as-taggable-on"
gem "autoprefixer-rails"
gem "business_time"
gem "bourbon"
gem "clockwork"
gem "daemons" # for delayed_job
gem "delayed_job_active_record"
gem "flutie"
gem "foreman"
gem "holidays"
gem "jquery-rails", ">= 4.4.0"
gem "kaminari", ">= 1.2.1"
gem "neat"
gem "omniauth-github-team-member"
gem "omniauth-rails_csrf_protection", "~> 0.1", ">= 0.1.2"
gem "paranoia"
gem "pg"
gem "puma"
gem "rack-canonical-host"
gem "recipient_interceptor"
gem "sassc-rails", ">= 2.1.2"
gem "simple_form", ">= 5.1.0"
gem "slack-ruby-client"
gem "sprockets", ">= 3.0.0"
gem "sprockets-es6"
gem "title", ">= 0.0.8"
gem "uglifier"

group :development, :test do
  gem "awesome_print"
  gem "bullet"
  gem "bundler-audit", ">= 0.5.0", require: false
  gem "byebug"
  gem "dotenv-rails", ">= 2.7.6"
  gem "factory_bot_rails", ">= 6.1.0"
  gem "pry-rails"
  gem "rspec-rails", ">= 5.0.1"
end

group :development do
  gem "listen"
  gem "spring"
  gem "spring-commands-rspec"
  gem "rubocop", require: false
end

group :test do
  gem "poltergeist", ">= 1.18.1"
  gem "capybara", ">= 3.34.0"
  gem "database_cleaner"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "sinatra"
  gem "timecop"
  gem "webmock"
end

group :staging, :production do
  gem "rack-timeout"
  gem "rails_stdout_logging"
end
