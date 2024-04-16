# Daniel-n01465744-project
Cloud Computing Graduate Certificate 5502 Automation Course Project Implementation

## Prerequisites:
- Have terraform and ansible installed
- Setup NOPASSWD
- Create a storage account and container for remote backend
- Create a keyvault with passwords for WindowsAdminPassword and psqlpassword

## How to provision:
- cd terraform
- terraform init
- terraform apply -auto-approve

## How to run ansible playbooks
- cd ansible
- ansible-playbook setup_users_localhost.yml
- ansible-playbook playbook.yml
