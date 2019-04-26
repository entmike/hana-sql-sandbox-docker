# Summary
This Docker Image can be used to run a container that will connect to a HANA DB and let you run simple SQL Statements to a HANA DB.

It is based on a Ubuntu image, and runs 2 modules that you can read more about here:

## Main Modules
1) https://github.com/entmike/hana-sql-sandbox-backend

2) https://github.com/entmike/hana-sql-sandbox-frontend

# Vanilla Usage
From a Terminal/Command Prompt/PowerShell/ssh session run:
```
docker run -t --rm \
-p 8888:80 \
-e HANA_SERVER=myhanabox.example.com \
-e HANA_PORT=39017 \
-e HANA_USER=SYSTEM \
-e HANA_PW=MySecretPassword \
entmike/hana-sql-sandbox:latest
```
To end, press Control-C in your Terminal/Command Prompt/PowerShell/ssh session.

# Usage Example when connecting to HANA Express running in its own Docker Container
```
docker run -t --rm --network SharedDockerNetwork \
-p 8888:80 \
-e HANA_SERVER=hxe \
-e HANA_PORT=39017 \
-e HANA_USER=SYSTEM \
-e HANA_PW=MySecretPassword \
entmike/hana-sql-sandbox:latest
```
*In this example, both this container and the HANA Express Container are expected to be running in Docker network `SharedDockerNetwork`.  The `HANA_SERVER` parameter will be the Container Name of your HANA Express Container.*