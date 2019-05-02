if [ ! -f ./hdbclientconfigured ]; then
	mkdir /hanaclient-installer
	tar -xvzf /app/hanaclient-2.4.126-linux-x64.tar.gz -C /hanaclient-installer
        rm /app/hanaclient-2.4.126-linux-x64.tar.gz
	/hanaclient-installer/client/hdbinst --path=/home/jupyteradm/sap/hdbclient
	su -l jupyteradm -c "cp ~/sap/hdbclient/hdbcli-*.tar.gz ~/hdbpkg.tar.gz"
	su -l jupyteradm -c "pipenv install file:///home/jupyteradm/hdbpkg.tar.gz"
	touch hdbclientconfigured
else
	echo "HDB Client and Python Package already run."
fi
