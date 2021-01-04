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

  # mpapis@gmail.com
  curl -sSL https://rvm.io/mpapis.asc | gpg --batch --import -; echo 409B6B1796C275462A1703113804BB82D39DC0E3:6: | gpg --batch --import-ownertrust

  # piotr.kuczynski@gmail.com
  curl -sSL https://rvm.io/pkuczynski.asc | gpg --batch --import -; echo 7D2BAF1CF37B13E2069D6956105BD0E739499BDB:6: | gpg --batch --import-ownertrust

  curl -sSL https://get.rvm.io | bash -s stable --autolibs=enabled --ruby=2.6.6

  export RUBY_VERSION="2.6.6"

  source "$HOME/.rvm/scripts/rvm"
  rvm install $RUBY_VERSION
  rvm use $RUBY_VERSION

  echo 'source "$HOME/.rvm/scripts/rvm"' >> .bashrc
  echo "rvm use $RUBY_VERSION" >> .bashrc

  # install postgres
  sudo apt-get -y install postgresql postgresql-contrib libpq-dev nodejs npm git libfontconfig
  sudo -u postgres psql -c "CREATE USER vagrant WITH PASSWORD 'vagrant';"
  sudo -u postgres psql -c "ALTER USER vagrant CREATEDB;"

  echo "localhost:5432:*:vagrant:vagrant" > .pgpass
  chmod 0600 .pgpass

  sudo npm install -g phantomjs-prebuilt

  cd /vagrant

  gem install bundler bundle
  cp .sample.env .env
  cp .sample.foreman .foreman

  ./bin/setup
  SHELL
end
