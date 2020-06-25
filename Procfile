web: bundle exec puma -p $PORT -C ./config/puma.rb
worker: bundle exec rake jobs:work
clock: bundle exec clockwork config/clock.rb
release: bundle exec rake db:migrate
