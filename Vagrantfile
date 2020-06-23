# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/bionic64"

  config.vm.network "forwarded_port", guest: 5000, host: 5000

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
  # print command to stdout before executing it:
  set -x
  set -e

  curl -sSL https://rvm.io/mpapis.asc | gpg --import -
  curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
  curl -L https://get.rvm.io | bash -s stable --autolibs=enabled --ruby

  export RUBY_VERSION="2.7.1"

  source "$HOME/.rvm/scripts/rvm"
  rvm install $RUBY_VERSION
  rvm use $RUBY_VERSION

  echo 'source "$HOME/.rvm/scripts/rvm"' >> .bashrc
  echo "rvm use $RUBY_VERSION" >> .bashrc

  # install postgres
  sudo apt-get -y install postgresql postgresql-contrib libpq-dev nodejs npm git
  sudo -u postgres psql -c "CREATE USER vagrant WITH PASSWORD 'vagrant';"
  sudo -u postgres psql -c "ALTER USER vagrant CREATEDB;"

  echo "localhost:5432:*:vagrant:vagrant" > .pgpass
  chmod 0600 .pgpass

  sudo npm install -g phantomjs

  cd /vagrant

  gem install bundle
  cp .sample.env .env

  ./bin/setup
  SHELL
end
