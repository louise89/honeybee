#! /usr/bin/env bash
set -e

main() {
  copy_application_settings
  bundle_application
  # yarn_install
  create_temp
  create_log
  create_database
  # create_unicorn_init_script
  # update_nginx_configs

  echo
  echo "========================================================================="
  echo
  echo "  INSTALLATION COMPLETE"
  echo
  echo "========================================================================="
  echo
}

copy_application_settings() {
  echo -n "Copying application settings... "
  cp -i config/application.yml.example config/application.yml
  echo "Done"
}

bundle_application() {
  echo -n "Bundling... "
  bundle install --no-binstubs --path vendor/bundle
  echo "Done"
}

yarn_install() {
  echo -n "Installing Node modules..."
  yarn install
  yarn build
  echo "Done"
}

create_temp() {
  echo -n "Creating Temp directories... "
  SKIP_RULES=true bundle exec rake tmp:create
  mkdir -p tmp/cache/development
  mkdir -p tmp/cache/test
  echo "Done"
}

create_database() {
  echo -n "Creating databases... "
  SKIP_RULES=true bundle exec rake db:setup
  SKIP_RULES=true bundle exec rake db:test:prepare
  echo "Done"
}

create_unicorn_init_script() {
  echo -n "Creating unicorn init script... "
  mkdir -p ~/Code/otb/unicorns
  rm -f ~/Code/otb/unicorns/unicorn_otb_www_app
  source_file=setup/unicorn/unicorn_otb_www_app
  config_file=~/Code/otb/unicorns/unicorn_otb_www_app
  ruby -r erb -e "f = File.read('${source_file}'); e = ERB.new(f); puts e.result" > $config_file
  chmod 0755 ~/Code/otb/unicorns/unicorn_otb_www_app
  echo "Done"
}

update_nginx_configs() {
  echo -n "Copying nginx files... "
  for config in $(config_files)
  do
    edit_and_replace_config $config
  done
  echo "Done"
}

config_files() {
  echo "setup/nginx/*"
}

edit_and_replace_config() {
  source_file=$1
  config_file=$(nginx_sites_enabled_dir)/$(basename $1)

  # Remove the destination file if it already exists
  if [ -e $config_file ] || [ -L $config_file ]; then
    sudo rm -f $config_file
  fi

  ruby -r erb -e "f = File.read('${source_file}'); e = ERB.new(f); puts e.result" | sudo tee $config_file &>/dev/null
}

nginx_sites_enabled_dir() {
  if [ -d /etc/nginx ]; then
    NGINX_PATH=/etc/nginx/sites-enabled
  else
    NGINX_PATH=/usr/local/etc/nginx/sites-enabled
  fi
  echo "$NGINX_PATH"
}

create_log() {
  echo -n "Creating log directories... "
  mkdir -p log
  echo "Done"
}

main
