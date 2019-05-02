#!/bin/bash
if [ ! -f ./jupyterconfigured ]; then
	useradd -m -d /home/jupyteradm -c "Jupyter Administrator" jupyteradm
	echo "HXEHana1\nHXEHana1" | passwd jupyteradm
	bash -c 'echo "jupyteradm ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers'
	bash -c 'echo "umask 022" >>/home/jupyteradm/.bashrc'
	bash -c 'echo "PATH=/home/jupyteradm/.local/bin:$PATH" >>/home/jupyteradm/.bashrc'
	apt-get install -y python-setuptools python-dev build-essential
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
	python get-pip.py
	su -l jupyteradm -c "pip install --user pipenv"
	su -l jupyteradm -c "pipenv install jupyterlab sqlalchemy sqlalchemy-hana ipython-sql"
	su -l jupyteradm -c "pipenv run jupyter-lab --generate-config"
        su -l jupyteradm -c "mkdir ~/notebooks"
	touch jupyterconfigured
else
	echo "Jupyter setup already run."
fi
