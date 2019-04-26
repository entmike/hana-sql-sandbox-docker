mkdir -p /run/nginx
rm /etc/nginx/sites-enabled/default
nginx
cd /hana-sql-sandbox-backend
npm run prod &