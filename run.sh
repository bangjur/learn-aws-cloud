#!/bin/sh

terraform plan
terraform -auto-approve
ansible-playbook fetch_ec2_ips.yml
ansible-playbook -i ip-targets.ini setup-servers.yml 
