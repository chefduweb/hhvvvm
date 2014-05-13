# Install HHVM
echo "Setup the HHVM repository"
sudo wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -
echo deb http://dl.hhvm.com/ubuntu trusty main | sudo tee /etc/apt/sources.list.d/hhvm.list
sudo apt-get update
sudo apt-get install hhvm -y --force-yes
sudo chown vagrant /etc/hhvm

echo "Move HHVM my-php.ini"
cd /
sudo cp /srv/www/__config/hhvm-config/php.ini /etc/hhvm/my-php.ini
sudo hhvm -m daemon -c /etc/hhvm/my-php.ini -v Eval.EnableXHP=1
sudo update-rc.d hhvm defaults

# Restart NGINX
echo "Restart nginx to apply HHVM changes"
sudo service nginx restart
sudo service hhvm restart

# Init script for all custom sites
echo "Commencing Custom Sites Setup"
echo "Copying NGINX WordPress subdirectory configuration"

cd /
sudo cp /srv/www/__hhvvvm/nginx-wp-subdirectory.conf-sample /etc/nginx/nginx-wp-subdirectory.conf
echo " * /srv/www/__hhvvvm/nginx-wp-subdirectory.conf -> /etc/nginx/nginx-wp-subdirectory.conf"

# Let the user know the good news
echo "Custom subdirectory WordPress sites will now work with HHVM";