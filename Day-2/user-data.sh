#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd
sudo echo "<h1>Hello Sanjay desai!!</h1>" > /var/www/html/index.html