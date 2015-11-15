provision-ec2: 
	ansible-playbook -i ansible/hosts ansible/provision.yaml

bootstrap:
	ansible-playbook -i ansible/hosts -l remote ansible/bootsrap.yaml

cleanall: clean
	rm -rf files/
