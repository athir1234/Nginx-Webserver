#!/bin/bash
sudo apt -y update

#install nginx
sudo apt -y install nginx
sudo systemctl start nginx