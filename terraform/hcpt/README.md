# hcpt

This folder contains HCL that manages HCP Terraform resources that will execute the demo code in a VCS workflow.

## HCP Terraform Configuration

This implementation doesn't presuppose any existing deployment management framework for an HCP Terraform organization, but does require a GitHub App Installation in the HCPT Organization for the owner of the GitHub repository. 

Managing the GitHub App Installation for HCP Terraform is out of scope, but for more information please [review the documentation](https://developer.hashicorp.com/terraform/cloud-docs/vcs/github-app).

## HCP Terraform Authorization

This repository uses the ```tfe``` terraform provider to manage the target HCP Terraform organization.

The provider is authenticated using a HCP Terraform API token. The minimum authorizaton scope is a team organization-level permission to manage projects. This is the recommended pattern for this demo. It must be noted that this token will be able to manage ALL projects in the org.

Other options are using an Organization token, or an user token that either has Owner permissions, or is a member of a team that has organization-level permission to manage projects.

## Using the API token.

The ```tfe``` provider will automatically use an environment variable with the value of TFE_TOKEN. Set the value of this variable to be that of the token.

The provider will also make use of stored local credential set by the ```terraform``` CLI.

Execute the following command, follow the instructions and provide the token with the desired scope:

```bash
terraform login
```

It is recommended to logout of the terraform when you have finished using this token.

```bash
terraform logout
```

## Usage

This code will bootstrap the workflow that deploys the dynamic module code. After this code is executed please interact with the created workspace to 

Use this folder to deploy or update the Terraform Cloud workspace metadata for the repo:

```bash
cd terraform/hcpt
terraform init
terraform plan
terraform apply
```

The workspace is configured to point at the repository folder `terraform/dynamic_modules_sources`.


<!-- BEGIN_TF_DOCS -->
{{ .Content }}
<!-- END_TF_DOCS -->
