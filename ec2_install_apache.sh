#!/bin/bash
sudo yum install -y httpd
sudo systemctl start httpd
sudo aws s3 cp s3://best-web-catalouge/ /var/www/html/  --recursive