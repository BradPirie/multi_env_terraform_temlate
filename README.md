# TEMP DCOUMENT
This needs to be updated with more detail.

# Terraform Environments
Develpment=**dev-sa**

QA=**qa-sa**

# Planning Terraform
This needs to be run first in the root directory of the terraform repository.

**DEV**

`ENV=dev-sa make plan`

**QA**

`ENV=qa-sa make plan`

# Actioning Terrafrom changes
Once running the plan command above command run the following

**DEV**

`ENV=dev-sa make apply`

**QA**

`ENV=qa-sa make apply`

# Additional Notes
Terraform uses s3 as a backend and stores a lock file in DynamoDB. Logining in via sso is required before running.