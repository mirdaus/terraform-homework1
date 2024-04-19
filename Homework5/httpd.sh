#!/bin/bash

sudo yum install httpd -y 
sudo systemctl start apache2
sudo systemctl enable apache2