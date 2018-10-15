---
title: Environments
---

An environment is a set of components used to create an infrastructure for a
common purpose. We use individual, isolated environments for the purposes of
staging and production. This allows us to properly test changes before
applying them to production and reduces the blast radius.

**Note:** Terraform refers to the notion of environments as 'workspaces'.

## Creating a new environment

Creating a new environment (also referred to as bootstrapping) is a relatively
trivial task using Terraform. If you haven't already done so create a private key
pair or obtain it from another team member:

    $ make keygen

Then use Terraform to create the new environment:

    $ make create-env ENV=staging

Next generate a Terraform plan:

    $ make plan

And finally run the Terraform apply command to create the AWS resources:

    $ make apply

This step will take approximately 20-30 minutes. If the command fails due to a
timeout or error then it is safe to run again.

Please refer to the Setup Guide for more information on installing Magento.

## Destroying an environment

Destroying an environment takes approximately 10 minutes. Use the `destroy` command:

        $ make destroy

Note: you must type 'yes' to proceed. Be sure not to use this command unless you are
absolutely sure what you are doing.
