#!/bin/bash

export AWS_REGION=eu-west-2 
export AWS_ACCOUNT=your-account

if [[ $(aws --version) == *"aws-cli/2"* ]]; then
  # --no-verify-ssl should be removed !
  aws ecr get-login-password --no-verify-ssl --region $AWS_REGION| docker login --username AWS --password-stdin ${AWS_ACCOUNT}
else
  $(aws ecr get-login --no-include-email --region $AWS_REGION)
fi
