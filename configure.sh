#!/bin/bash
#
#terraform destroy -auto-approve

if [[ -z "${TF_VAR_VES_P12_PASSWORD}" ]]; then
  read -s -p "Enter cert passphrase: " TF_VAR_VES_P12_PASSWORD
  if [ ! "${TF_VAR_VES_P12_PASSWORD}" ]; then echo "Error: no value, start again: "; exit; fi
  echo "*********************"
  export TF_VAR_VES_P12_PASSWORD
fi

if [[ -z "${TF_VAR_libvirt_admin}" ]]; then
  read -p "Enter KVM admin user: " TF_VAR_libvirt_admin
  if [ ! "${TF_VAR_libvirt_admin}" ]; then echo "Error: no value, start again: "; exit; fi
  export TF_VAR_libvirt_admin
fi

if [[ -z "${TF_VAR_libvirt_ip}" ]]; then
  read -p "Enter KVM IP address: " TF_VAR_libvirt_ip
  if [ ! "${TF_VAR_libvirt_ip}" ]; then echo "Error: no value, start again: "; exit; fi
  export TF_VAR_libvirt_ip
fi

if [[ -z "${TF_VAR_tenant}" ]]; then
  read -p "Tenant Name: " TF_VAR_tenant
  if [ ! "${TF_VAR_tenant}" ]; then echo "Error: no value, start again: "; exit; fi
  export TF_VAR_tenant
fi

export TF_VAR_VOLT_API_P12_FILE="./creds/jpmc.console.ves.volterra.io.api-creds.p12"

terraform providers lock -platform=linux_amd64
terraform init -upgrade
terraform plan
#terraform destroy -auto-approve
terraform apply -auto-approve
