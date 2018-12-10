#!/usr/bin/make -f

AP := ansible-playbook
AG := ansible-galaxy
AI := inventory

AF := -vv

.PHONY: roles


serial: provision nodejs mongodb wisdom

clean:
	vagrant destroy -f

provision:
	vagrant up

reprovision: clean provision

roles:
	$(AG) install -r roles/requirements.yml -p roles

roles_clean:
	$(AG) install -r roles/requirements.yml -p roles --force

nodejs:
	$(AP) -i $(AI) nodejs-setup.yml $(AF)

mongodb:
	$(AP) -i $(AI) mongodb-setup.yml $(AF)

haproxy:
	$(AP) -i $(AI) haproxy-setup.yml $(AF)

wisdom:
	$(AP) -i $(AI) nodejs-app.yml $(AF)

pb-%:
	$(AP) -i $(AI) $*

stack-setup: pb-nodejs-setup.yml pb-mongodb-setup.yml
	echo "DONE"

stack: stack-setup wisdom
