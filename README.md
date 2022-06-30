# Project Status

![pipeline](https://gitlab.com/ezuchetti/terraform-aws-cognito-user-pool/badges/main/pipeline.svg) 
![Latest Release](https://gitlab.com/ezuchetti/terraform-aws-cognito-user-pool/-/badges/release.svg)

# Introduction
Module for create Cognito UserPools, Clients, Pool Domain and UI Customization

The original repo is on GitLab! Check here [ezuchetti/terraform-aws-cognito-user-pool](https://gitlab.com/ezuchetti/terraform-aws-cognito-user-pool)

Also check the module in de Teraform Registry: [eduzuchetti/cognito-user-pool/aws](https://registry.terraform.io/modules/eduzuchetti/cognito-user-pool/aws)

<br>

# Whats this module creates?
- Cognito User Pool
- Cognito Clients
- Cognito Pool Domain
- Cognito Ui Customization

<br>

# How to use this Module
Create a module resource with this repo as source:
```
module "cognito_user_pools" {
  source = "eduzuchetti/cognito-user-pool/aws"
  version = "1.0.0"

  user_pools = {}
  user_pool_client = {}
}