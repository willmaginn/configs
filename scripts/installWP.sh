#!/bin/bash

#
# Script to install latest version of wordpress and setup and activate plugins
#
# Author: Will Maginn
# Date: 25/11/14
# Ver:	0.2
#

function createDirectory {
	# If folder does not exist create one
	if [ ! -d "$1" ]; then
		mkdir $1	
	fi
}

echo "Installing Wordpress"

# Variables

EXPECTED_ARGS=

MYSQL_DB="harbour2" #Dynamic!
URL_PATH="localhost/projects/harbour" #Dynamic!
WP_TITLE="Harbour" #Dynamic!
WP_USER="wpadmin" #Dynamic
WP_PASS="password" #Dynamic
WP_EMAIL="wordpress@example.org" #Dynamic

USERNAME="root"
PASSWORD="password"
TABLE_PREFIX="KNp1548u_" #Dynamic
DATE=$(date +%Y-%m-%d)
TIME=$(date +%T)

echo "Install Wordpress Script"

while true; do
	read -e -p "Where is the install directory: " INSTALL_DIRECTORY

	if [ -z "$INSTALL_DIRECTORY" ]; then
		echo "Please enter a directory"
	else
		createDirectory $INSTALL_DIRECTORY
		echo "Created install directory"
		
		echo "Install Wordpress Core"
		wp core download --path=$INSTALL_DIRECTORY
		break
	fi
done

while true; do
	read -e -p "Database name: " MYSQL_DB

	if [ -z "$MYSQL_DB" ]; then
		echo "Please enter a database name"
	else 
		break
	fi
done

while true; do
	read -e -p "Database username: " USERNAME

	if [ -z "$USERNAME" ]; then
		echo "Please enter a username"
	else 
		break
	fi
done

while true; do
	read -e -p "Database password: " PASSWORD

	if [ -z "$PASSWORD" ]; then
		echo "Please enter a password"
	else 
		break
	fi
done

while true; do
	read -e -p "Table prefix (e.g. wp_KNp1548u_): " TABLE_PREFIX

	if [ -z "$TABLE_PREFIX" ]; then
		echo "Please enter a table prefix"
	else 
		break
	fi
done

while true; do
	read -e -p "URL Path: " URL_PATH

	if [ -z "$URL_PATH" ]; then
		echo "Please enter a url path"
	else 
		break
	fi
done

while true; do
	read -e -p "Title: " WP_TITLE

	if [ -z "$WP_TITLE" ]; then
		echo "Please enter a title"
	else 
		break
	fi
done

echo "Create wp-config.php"
wp core config --path=$INSTALL_DIRECTORY --dbname=$MYSQL_DB --dbuser=$USERNAME --dbpass=$PASSWORD --dbhost="127.0.0.1" --dbprefix=$TABLE_PREFIX

echo "Creating Database..."
wp db create --path=$INSTALL_DIRECTORY

echo "Run Install"
wp core install --path=$INSTALL_DIRECTORY --url=$URL_PATH --title='$WP_TITLE' --admin_user=$WP_USER --admin_password=$WP_PASS --admin_email=$WP_EMAIL

echo "Wordpress Install Complete"

echo "Creating additional users"

# wp user create wpadmin wordpress@example.org --role=admin --user_pass=password --path=$INSTALL_DIRECTORY

echo "Installing Plugins"

wp plugin install contact-form-7 --path=$INSTALL_DIRECTORY --activate --force
wp plugin install wordpress-seo --path=$INSTALL_DIRECTORY --activate --force
wp plugin install google-sitemap-generator --path=$INSTALL_DIRECTORY --activate --force
wp plugin install wordpress-importer --path=$INSTALL_DIRECTORY --activate --force
wp plugin install jetpack --path=$INSTALL_DIRECTORY --activate --force
wp plugin install ricg-responsive-images --path=$INSTALL_DIRECTORY --activate --force

wp plugin install debug-bar --path=$INSTALL_DIRECTORY --activate --force
wp plugin install log-deprecated-notices --path=$INSTALL_DIRECTORY --activate --force
wp plugin install monster-widget --path=$INSTALL_DIRECTORY --activate --force
wp plugin install regenerate-thumbnails --path=$INSTALL_DIRECTORY --activate --force
wp plugin install vip-scanner --path=$INSTALL_DIRECTORY --activate --force
wp plugin install vip-scanner --path=$INSTALL_DIRECTORY --activate --force
wp plugin install wordpress-beta-tester --path=$INSTALL_DIRECTORY --activate --force

wp plugin update --all

wp import theme-unit-test-data.xml --path=$INSTALL_DIRECTORY --authors=create

sudo apachectl restart