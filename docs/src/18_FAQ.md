---
title: FAQ
---

This section describes frequently ask questions and potential solutions.

## Updating the ECS AMI

The ECS AMI is built using Packer:

    $ make bake-ami

Then you need to edit the `variables.tf` file and update `ecs_ami` the variable.

Finally run the Terraform plan and apply commands.

**Note:** Be sure to change the `app_task_count` to two times the number of
App Servers as described in the Scaling section.

## Troubleshooting Terraform

In the event of a Terraform failure, turn on the debug mode and re-run the `plan`
step to see exactly what happens:

    $ export TF_LOG=debug
    $ make plan

## How can I FTP/SFTP into the server(s)?

Unfortunately FTP/SFTP server is not possible due to the complexity of the architecture.
In simple terms due to the fact we deploy our applications to multiple servers means it
is not feasible to provide FTP/SFTP access as that would imply accessing a single
implicit server. If the code needs to be modified then the best channel would be
our existing workflow via GitHub & CircleCI. If the server setup needs to be modified
then the best channel would be through our Terraform code. Please refer to the
Architecture, Deployment & Infrastructure guides for more information.
