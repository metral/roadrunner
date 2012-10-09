#!/bin/bash

sudo apt-get update
sudo apt-get install build-essential -y
wget http://nodejs.org/dist/v0.8.11/node-v0.8.11.tar.gz
tar xzvf node*.tar.gz
cd node*

./configure
make -j 4
sudo make install

sudo npm install
