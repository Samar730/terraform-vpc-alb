#!/bin/bash
set -eux

# Update packages
apt-get update -y

# Install nginx
apt-get install -y nginx

# Enable and start nginx
systemctl enable nginx
systemctl start nginx

# Get private IP using IMDSv2
TOKEN=$(curl -sX PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

PRIVATE_IP=$(curl -sH "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/local-ipv4)

# Overwrite default index page
echo "Hello World from $PRIVATE_IP" > /var/www/html/index.html