#!/usr/bin/env bash

#terraform destroy -force

rm -rf .terraform/ plan *.tfstate*

terraform init

terraform plan --var-file=fanix.tfvars -out "plan"
terraform apply "plan"