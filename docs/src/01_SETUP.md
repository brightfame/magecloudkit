---
title: Setup Guide
---

This section explains how to setup a developer's machine in order to contribute
to the MageCloudKit Ops code. We recommend using macOS, but the instructions can easily
be adapted for Linux systems. Windows users may wish to use the [Ubuntu for Windows](https://www.microsoft.com/en-us/store/p/ubuntu/9nblggh4msv6)
application. For information on creating a new environment please refer to the
Environments section.

We use [Terraform](https://www.terraform.io) and [Packer](https//www.packer.io) from
the Hashicorp suite in order to manage our infrastructure as code and ensure consistent,
repeatable processes. Packer is used to build the underlying AMI images that our App
servers use. Terraform is used to orchestrate the infrastructure and provision the instances.

## Prerequisite Software

You should have the following software tools installed locally:

 * Packer (at least v1.2.1)
 * Terraform (at least v0.11.4)
 * AWS CLI tools (at least v1.11.170)
 * [Docker for Mac](https://docs.docker.com/engine/installation/mac/)
 * [jq](https://stedolan.github.io/jq)
 * [awslogs](https://github.com/jorgebastida/awslogs)
 * [Admiral](https://github.com/robmorgan/admiral) by Rob Morgan

If you are using macOS then you can use the [Homebrew](https://brew.sh/) package manager
to install all of them excluding Admiral and Docker for Mac.

    $ make dev-bootstrap

Admiral requires a Go runtime and can be installed like so:

    $ brew update && brew install go
    $ go get -u -v github.com/robmorgan/admiral

## The Makefile

We use a self-documented `Makefile` to perform most of the common Ops related tasks. You
can simply execute it without any arguments to see a list of the available commands:

    $ make

[![Makefile output](makefile.jpg)](makefile.jpg)

It is important to familiarise yourself with the Makefile as it is frequently used in the
other steps.

## Initialize Terraform

We need to configure Terraform to use the remote S3 bucket for storing state
and download the required plugins. Run the following commands:

    $ make global-init
    $ make init

## AWS Credentials

In order to create or modify resources you will need an AWS IAM key pair with a privileged
policy attached. These credentials can be easily created using the AWS console.

 1. Open the AWS Console in your web browser.
 2. Create or ensure a new IAM Group called 'Admins' exists.
 3. Attach (or ensure) the AWS 'AdministratorAccess' policy (applies) to the group.
 4. Create a new IAM user and add it to the 'Admins' group.
 5. Click on the user then find the 'Security Credentials' tab.
 6. Use the 'Create access key' button to create new AWS access keys.

We recommend to create the IAM users in the form: first initial/last name.

e.g: `rmorgan` for Rob Morgan.

Next we need to configure our local environment:

    export AWS_DEFAULT_REGION=us-east-1
    export AWS_ACCESS_KEY_ID=xyz
    export AWS_SECRET_ACCESS_KEY=xyz

**Note:** As a best practice you should add these variables to your `.bashrc` or `.zshrc`
file so they are always available.

Then run `aws configure` to configure the AWS CLI tools.

Now test your configuration:

```
$ aws ec2 describe-instances
```

If the credentials are valid then you should see no errors.

## Optional: Adding your SSH keys

Public SSH keys can be added in the `ssh_keys` directory. These keys will be automatically
provisioned onto the servers. If you have an SSH public key then add it to this directory
in the format: `keyname.pub`.

## Baking a new App AMI

We bake the App AMIs using Packer. The App AMI is an Amazon Machine Image used to
launch App Servers inside a given environment.

To bake an AMI, simply run:

    $ make bake-ami

Packer will run and bake the App AMI. This process will take roughly 10 minutes. When Packer
finishes it will output an 'AMI ID'. Be sure to note this value down as we'll need it in a
future step. The AMI ID takes the format: `ami-XXYYZZZZ`.

**Note:** You can also use the `get-ami` command to access the AMI ID in the future:

    $ make get-ami

## Create or obtain the private deployer SSH key pair

The private deployer key will be created under `ssh_keys/private`. Copy the public
key (`deployer.pub`) and ensure its updated in `terraform/key-pairs.tf`. This key
will be shared amongst the engineers and be used for provisioning code on the
instances.

**Note:** This has already been done by Rob and is available in the shared S3 bucket.
You can easily download it locally with the following commands providing you have access:

    $ mkdir -p ./private
    $ aws s3 sync s3://MageCloudKit-ops/ssh_keys/private private

If you need to generate a new key pair yourself, simple run:

    $ make keygen

This will generate the required files under the `private` directory. It is recommended to share
this key pair amongst your team.

## Creating a new environment

Now its time to create a new environment. Simply run:

    $ make create-env ENV=production

Next run the Terraform plan command:

    $ make plan

And finally run the Terraform apply command to create the AWS resources:

    $ make apply

This step will take approximately 20-30 minutes. If the command fails creating AWS resources due to a
timeout or error then it is safe to run again.

## Running the Magento Setup Wizard

In order to create the database and initialize Magento we need to run the setup wizard using the ECS Run Task feature.

    $ aws ecs run-task --cluster production-app --task-definition production-magento2-setup:1

The Magento installer will take approximately 5-10 mins to complete. If desired you can watch
the setup progress from the AWS CloudWatch Logs console or by using the `awslogs` tool:

    $ awslogs get production-app -w

## Visit Your Store

Congratulations! Your new environment should now be available. Unless configured otherwise
the admin URL will be accessible at `http://<yourdomain>/admin_uo58yn`.

The default admin credentials are:

* Username: `magecloudkit`
* Password: `M@gecl0udk1t`

**Note:** We recommend changing them as soon as possible.
