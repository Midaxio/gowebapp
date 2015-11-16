#Tools used:
- Ansible: To provision the EC2 instances that will run the application we use Ansible, which provides an EC2 module to easily interact with AWS' API.
- Chef: To bootstrap and configure the EC2 instances we will use Chef. It will configure both the Nginx proxy and the application server running the Go application. A recipe is also provided to deploy the application.
- Vagrant: To avoid installing tools locally we provide a Vagrant box (devbox). The development of the Chef an Ansible code has been done on that box.
- Automake: GNU's make utility is used to drive the different components. 
- Blackbox: AWS secrets and ssh keys are stored encrypted (gpg) for obvious reasons. Blackbox will unencrypt these secrets provided you're added as admin. **Being an admin is a hard requirement to run this project locally.**
- Jenkins: The recommended way is to use [Jenkins](http://jenkins.dev.midax.io:8080). A webhook will automatically deploy the application when a change is commited to [Github](https://github.com/urtens/golang)

#Pre-equirements 
- Vagrant
- Virtualbox
- Automake

#Usage
* Build the development vagrant box
```
    make devbox
```

* Provision and bootstrap the EC2 instances
```
    make provision-ec2
```

* Test the setup
```
    make test
```
