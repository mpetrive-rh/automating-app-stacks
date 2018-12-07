#!/usr/bin/make -f

AP := ansible-playbook
AG := ansible-galaxy

.PHONY: roles

roles:
	$(AG) install -r roles/requirements.yml -p roles --force

nodejs:
	$(AP) -i vagrant.py nodejs-setup.yml -l nodejs -vv

mongodb:
	$(AP) -i vagrant.py mongodb-setup.yml -l mongodb -vv
