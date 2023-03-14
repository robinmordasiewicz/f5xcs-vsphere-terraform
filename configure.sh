#!/bin/bash
#
read -e -i ${TF_VAR_tenant} -p "Tenant Name: " TF_VAR_tenant

if [[ "${TF_VAR_tenant}" ]]; then
  export TF_VAR_tenant
  export TF_VAR_VOLT_API_P12_FILE="${TF_VAR_tenant}.console.ves.volterra.io.api-creds.p12"
  export VOLT_API_P12_FILE="${TF_VAR_tenant}.console.ves.volterra.io.api-creds.p12"
  if [[ -f "$TF_VAR_VOLT_API_P12_FILE" ]]; then
    read -e -s -p "Enter cert passphrase: " TF_VAR_VES_P12_PASSWORD
    echo "Enter cert passphrase: ***********"
    export TF_VAR_VES_P12_PASSWORD
    export VES_P12_PASSWORD=${TF_VAR_VES_P12_PASSWORD}
  fi
else
  echo "Error: no value, start again: "
fi
