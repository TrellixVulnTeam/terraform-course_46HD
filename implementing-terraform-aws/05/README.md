##################################################################################
### __Remote state set up__
# Linux
##################################################################################
export AWS_PROFILE=infra
##################################################################################
# Windows
$env:AWS_PROFILE="infra"

terraform init

terraform validate

terraform plan -out state.tfplan

terraform apply state.tfplan

# Make note of the s3 bucket name and dynamodb table name

##################################################################################
