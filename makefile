#!/usr/bin/make -f

AP := ansible-playbook
AG := ansible-galaxy
#AI := inventory-vagrant
AI := inventory-ec2

AF := -vvvv

AG := "-l car_app_2node"

.PHONY: roles

serial: provision nodejs mongodb wisdom

app1-%:
	make $* AG="-l car_app_2node"

app2-%:
	make $* AG="-l car_app_3node"

app3-%:
	make $* AG="-l car_app_noproxy"

clean:
ifeq ($(AI), inventory_vagrant)
	vagrant destroy -f
else
	$(AP) -i $(AI) ec2-destroy.yml $(AG)
endif

provision:
ifeq ( $(AI), inventory_vagrant )
	vagrant up
else
	$(AP) -i $(AI) ec2-deploy.yml $(AG)
endif

reprovision: clean provision

roles:
	$(AG) install -r roles/requirements.yml -p roles

roles_clean:
	$(AG) install -r roles/requirements.yml -p roles --force

nodejs:
	$(AP) -i $(AI) nodejs-setup.yml $(AF) $(AG)

mongodb:
	$(AP) -i $(AI) mongodb-setup.yml $(AF) $(AG)

haproxy:
	$(AP) -i $(AI) haproxy-setup.yml $(AF) $(AG)

wisdom:
	$(AP) -i $(AI) nodejs-app.yml $(AF) $(AG)

wisdom-data:
	$(AP) -i $(AI) nodejs-app-data.yml $(AF) $(AG)

pb-%:
	$(AP) -i $(AI) $* $(AF) $(AG)

stack-provision: provision

stack-setup1:; @$(MAKE) _stack-setup1 -j3
_stack-setup1: pb-nodejs-setup.yml pb-mongodb-setup.yml pb-haproxy-setup.yml
	echo "Done with setup playbooks"

stack-setup: _stack-setup stack-app stack-app-data

_stack-setup:; @$(MAKE) __stack-setup -j3

__stack-setup: nodejs mongodb haproxy
	echo "Done with setup playbooks"

stack-app: wisdom

stack-app-data: wisdom-data
