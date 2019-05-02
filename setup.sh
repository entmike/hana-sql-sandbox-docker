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
npm run prod & 
echo "Starting Jupyter Notebook..."
su -l jupyteradm -c "pipenv run jupyter lab --ip=0.0.0.0 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.notebook_dir='/home/jupyteradm/notebooks'"
