#!/usr/bin/env bash

rm -rf .terraform/ plan *.tfstate*

terraform init

terraform plan -out "plan"
terraform apply "plan"