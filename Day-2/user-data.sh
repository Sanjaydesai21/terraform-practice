#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
echo "<h1>Hello Sanjay desai!!</h1>" | tee /usr/share/nginx/html/index.html