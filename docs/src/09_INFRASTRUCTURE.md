---
title: Infrastructure
---

This section describes how to use and modify the infrastructure.

**Note:** You should read the Terraform [Getting Started](https://www.terraform.io/intro/getting-started/install.html)
before attempting to modify the infrastructure.

In addition it is also helpful to read Rob Morgan's blog post on
[Rolling Deployments](https://robmorgan.id.au/posts/rolling-deploys-on-aws-using-terraform/)
with Terraform.

## Changing Environments

You can change between the production and staging environments by using the Makefile command:

    $ make set-env ENV=production
    $ make set-env ENV=staging

You can also begin the process of creating a new environment by passing in a new name:

    $ make set-env ENV=qa

Keep in mind the Terraform code has a lot of hash maps that will need to be updated to
reference the new environment. The majority of them are in the `variables.tf` and `main.tf`
files.

## Modifying the Infrastructure

Simply edit the infrastructure code stored underneath the `terraform` subdirectory. Then use
the Terraform `plan` command to review the desired changes:

      $ make plan

Finally invoke Terraform again to apply your changes to the given environment:

      $ make apply

**Note:** Much like code, Infrastructure changes should be tested first in a separate
staging environment.
