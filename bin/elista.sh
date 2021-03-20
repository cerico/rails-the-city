source config/elista.env

ssh deploy@207.180.194.212 << EOF
  cd /var/www/html
  echo rails_city
  bash -i
  if [ -d rails_city ]
  then
    echo "hello"
    cd rails_city
    git pull origin main
    which ruby
    rbenv versions
    if [ -d /home/deploy/.rbenv/versions/2.7.1 ]
      then
      rbenv local 2.7.1
    else
      rbenv install 2.7.1
      rbenv local 2.7.1
    fi
    RAILS_ENV=production
    bundle config set without 'development test'
    bundle update
    RAILS_ENV=production bundle install
    yarn install --check-files
    ./bin/webpack --mode production
    RAILS_ENV=production bundle exec rake db:migrate
    sudo service nginx reload
  else
    git clone https://github.com/cerico/rails-the-city.git rails_city
    cd rails_city
    if [ -d /home/deploy/.rbenv/versions/2.7.1 ]
      then
      rbenv local 2.7.1
    else 
      rbenv install 2.7.1
      rbenv local 2.7.1
    fi
  fi
EOF
ssh -q deploy@heyu.larchtre.es  "[[ -f /var/www/html/rails_city/config/master.key ]]"
retVal=$?
echo 
if [ $retVal -eq 0 ]; then
  echo "Done!"
  exit
fi
ls
sftp deploy@heyu.larchtre.es << EOF
  cd /var/www/html/rails_city/config
  mput config/master.key
  cd /etc/nginx/conf.d
  mput config/nginx/*
EOF
ssh deploy@heyu.larchtre.es << EOF
  bash -i
  cd /var/www/html/rails_city
  password=`echo 'Rails.application.credentials.production[:db_password]' | RAILS_ENV=production bundle exec rails c | tail -2 | head -1 | tr -d '"'`
  sudo -u postgres psql -c "CREATE user rails_city PASSWORD '$password' createdb";
  RAILS_ENV=production
  bundle config set without 'development test'  
  bundle install
  spring stop
  yarn install --check-files
  ls bin
  ./bin/webpack --mode production
  RAILS_ENV=production bundle exec rake db:create
  RAILS_ENV=production bundle exec rake db:migrate
  RAILS_ENV=production bundle exec rake db:seed
  RAILS_ENV=production bundle exec rails assets:precompile
  sudo service nginx reload
EOF
 echo "Done!"
