#!/bin/bash
sudo apt update -y
sudo apt install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd
sudo echo "<h1>Hello Sanjay desai!!</h1>" > /var/www/html/index.html