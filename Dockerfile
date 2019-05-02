# Use an official Ubuntu Xenial as a parent image
FROM ubuntu:16.04

LABEL Maintainer="Mike Howles <mike.howles@gmail.com>"

# Install Node, nginx, Git
RUN apt-get update && apt-get install -y apt-transport-https
RUN apt-get install -y build-essential curl git nginx
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN apt-get install -y nodejs

# Clone Git Repos
WORKDIR /
RUN git clone https://github.com/entmike/hana-sql-sandbox-backend && \
git clone https://github.com/entmike/hana-sql-sandbox-frontend

# Install backend API
WORKDIR /hana-sql-sandbox-backend
RUN npm config set @sap:registry https://npm.sap.com && npm install @sap/hana-client
RUN npm install

# Install frontend API
WORKDIR /hana-sql-sandbox-frontend
RUN npm install
ENV VUE_APP_HANA_SQL_SANDBOX_BACKEND=/backend
RUN npm run build

# Configure nginx and startup
COPY ./server.conf /etc/nginx/conf.d/default.conf
WORKDIR /app
# Launcher Script
COPY ./setup.sh /app/setup.sh
RUN chmod +x ./setup.sh
# Jupyter Setup
COPY ./jupyter-setup.sh /app/jupyter-setup.sh
RUN chmod +x ./jupyter-setup.sh
RUN ./jupyter-setup.sh
# HDB CLient Setup
COPY ./hdbclient-setup.sh /app/hdbclient-setup.sh
RUN chmod +x ./hdbclient-setup.sh
ENTRYPOINT [ "/bin/bash" ]
CMD [ "/app/setup.sh" ]
