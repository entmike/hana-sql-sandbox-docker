#!/bin/sh
echo "Installing and configuring HDB Client \(if not done\)"
./hdbclient-setup.sh
echo "Starting Servers..."
mkdir -p /run/nginx
rm /etc/nginx/sites-enabled/default
echo "Starting nginx..."
nginx
cd /hana-sql-sandbox-backend
echo "Starting backend..."
npm run prod 
