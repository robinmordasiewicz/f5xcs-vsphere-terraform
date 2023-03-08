#!/bin/bash
#

if [[ -z "${TF_VAR_VES_P12_PASSWORD}" ]]; then
  read -s -p "Enter cert passphrase: " TF_VAR_VES_P12_PASSWORD
  if [ ! "${TF_VAR_VES_P12_PASSWORD}" ]; then echo "Error: no cert passphrase: "; exit; fi
  echo "*********************"
  export TF_VAR_VES_P12_PASSWORD
fi

export TF_VAR_VOLT_API_P12_FILE=./creds/.api-creds.p12
