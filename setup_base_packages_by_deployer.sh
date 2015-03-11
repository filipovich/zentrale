sudo aptitude update
sudo aptitude install -y \
  build-essential zlib1g-dev \
  libssl-dev openssl \
  libreadline-dev \
  sqlite3 libsqlite3-dev \
  libxslt-dev libxml2-dev \
  curl wget git-core imagemagick \
  mc \
  libpq-dev \
  nodejs postgresql postgresql-contrib \
  postgres-xc

git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
git clone git://github.com/dcarley/rbenv-sudo.git ~/.rbenv/plugins/rbenv-sudo

source ~/.bashrc

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install -y mongodb-org

echo 'export LC_ALL=C' >> ~/.bashrc

ruby_version=2.1.2

rbenv install $ruby_version
rbenv global $ruby_version
gem install bundler --no-ri --no-rdoc
rbenv rehash

sudo add-apt-repository ppa:nginx/stable
sudo apt-get -y update
sudo apt-get -y install nginx

# NOTE www-data user hasn't rigths to /var/www/apps folder (need for serving static assets)

sudo mkdir -p /var/www/apps
sudo chown -R deployer /var/www/apps
sudo chmod -R 0766 /var/www/apps

# install ruby version
# install bundler

# create role deployer;
# 
# postgresql roles
# https://www.digitalocean.com/community/tutorials/how-to-use-roles-and-manage-grant-permissions-in-postgresql-on-a-vps--2