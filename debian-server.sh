#!/bin/bash

echo -e "${c}Update dan Upgrade System"; $r
sudo apt update && sudo apt upgrade && sudo apt autoremove -y

echo -e "${c}install PHP"; $r
sudo apt install -y apt-transport-https lsb-release ca-certificates wget 
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list 
sudo apt update
sudo apt install apache2 php php-fpm php-gd php-xml php-mbstring php-curl php-zip php-intl -y

echo -e "${c}restart Apache2"; $r
sudo systemctl restart apache2

echo -e "${c}install composer"; $r
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer

echo -e "${c}restart MariaDB-Server"; $r
sudo apt install mariadb-server -y

echo -e "${c}restart mariadb"; $r
sudo systemctl start mariadb
sudo systemctl enable mariadb

echo -e "${c}setup mariadb"; $r
sudo mysql_secure_installation

echo -e "${c}Install phpMyAdmin"; $r
sudo apt install phpmyadmin -y

echo -e "${c}restart Apache2"; $r
sudo systemctl restart apache2

