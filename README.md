[![Build Status](https://travis-ci.org/a118n/boxes.svg?branch=master)](https://travis-ci.org/a118n/boxes)
[![Code Climate](https://codeclimate.com/github/a118n/boxes/badges/gpa.svg)](https://codeclimate.com/github/a118n/boxes)

# Boxes
Boxes is an asset management web application written primarily for managing printers, MFPs and their supplies. It may prove handy in large offices and corporations where you have to keep track of multitude of devices and supplies they use.

    Note: Currently under active development.

![screenshot](screenshot.png)

### Features
* You can easily assign specific supplies to a particular device and vice versa
* An overview page displays critial and important information, such as supplies that are about to run out of stock, devices that are in repair, etc
* Monthly usage reports for supplies that are delivered to your mailbox
* Monthly usage statistics for each individual supply
* Email notifications when supply is about to run out of stock (controlled by individual threshold)


### Installation
Note: This instruction describes a sample installation on a clean Ubuntu server with NGINX as a web server.
#### Application Stack
The following software is required before installing the application. For a detailed instructions please refer to software providers and distribution manuals.
* Ruby ≥ 2.3.1
* [Phusion Passenger](https://www.phusionpassenger.com/)
* [ElasticSearch](https://www.elastic.co/products/elasticsearch)
* [Redis](http://redis.io/)
* NGINX
* MariaDB (or MySQL)
* Node.js

#### Install required packages

```sudo apt-get install build-essential ruby ruby-dev git libmysqlclient-dev mariadb-server elasticsearch redis-server```

```sudo gem install bundler```

```curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
sudo apt-get install -y nodejs```

#### Clone the repo

```git clone https://github.com/a118n/boxes.git && cd boxes```

#### Bundle up

```bundle install --path vendor/bundle```

#### Set up database

``` sudo mysql_secure_installation```

```sudo mysql -u root```

```
MariaDB [(none)]>use mysql;
MariaDB [(mysql)]>update user set plugin=' ' where User='root';
MariaDB [(mysql)]>flush privileges;
MariaDB [(mysql)]>exit
```

```echo "export BOXES_DATABASE_PASSWORD='YourMySQLRootPassword'" >> ~/.bashrc```

```echo "export SECRET_KEY_BASE='$(bundle exec rails secret)'" >> ~/.bashrc```

```source ~/.bashrc```

```RAILS_ENV=production bundle exec rails db:setup```

#### Set up NGINX & Passenger

[This guide](https://www.phusionpassenger.com/library/install/nginx/install/oss/xenial/) describes installation of NGINX with Passenger.

[This guide](https://www.phusionpassenger.com/library/deploy/nginx/deploy/ruby/) describes application deployment.