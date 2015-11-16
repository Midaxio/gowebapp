SERVICE_URL := http://go.dev.midax.io/

.PHONY: test devbox

devbox:
	@cd devbox && $(MAKE) devbox 

localtest:
	@cd tests && $(MAKE) localtest

provision-ec2: devbox
	@cd devbox && vagrant ssh -c "cd ~/workspace/ansible && \
		ansible-playbook -i hosts provision.yaml" && \
		ansible-playbook -i hosts install-chef.yaml

test:
	@curl $(SERVICE_URL) && \
	printf '\n'
	@curl $(SERVICE_URL)

