# Terraform
The goal of this repository it's apply terraform's knowledge.

## Setting AWS Provider
AWS credentials can be provided by using the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables. Also, the region can be set using the `AWS_REGION` environment variable.

```
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
export AWS_REGION="us-west-2"
```

## Initializing Terraform module
Run the following command in order to set all declared providers and initialize the terraform project:

```
terraform init
```

Run the following command to check if there is any possible change to be made:

```
terraform plan
```

Run the following command to apply all pending changes:

```
terraform apply
```

Run the following commando to undo all changed made:

```
terraform destroy
```
