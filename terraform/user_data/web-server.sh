#!/bin/bash

apt-get update
apt-get install -yf build-essential \
    python2.7 \
    python-setuptools \
    python-pip \
    nginx \
    uwsgi \

mkdir -p /var/log/uwsgi
chown -R ubuntu:ubuntu /var/log/uwsgi

cat >/etc/nginx/sites-available/default <<EOL
server {
  listen 80;
  root /var/www;
  charset utf-8;
  client_max_body_size 75M;

  location / {
    try_files $uri @myapp;
  }

  location @myapp {
    include uwsgi_params;
    uwsgi_pass unix:/var/run/helloworldapp.sock
  }
}
EOL

mkdir /etc/uwsgi /var/log/uwsgi

cat >/etc/uwsgi/helloworld.conf <<EOL
[uwsgi]
#application's base folder
base = /var/www

#python module to import
app = helloworldapp
module = %(app)

home = %(base)/venv
pythonpath = %(base)

#socket file's location
socket = /var/run/helloworldapp.sock

#permissions for the socket file
chmod-socket    = 666

#the variable that holds a flask application inside the module imported at line #6
callable = app

#location of log files
logto = /var/log/uwsgi/%n.log
EOL

service nginx restart

killall uwsgi
uwsgi --ini /etc/uwsgi/helloworldapp.ini &
