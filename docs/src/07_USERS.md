---
title: User Management
---

Users (or developers) for the purposes of deployment and Ops administration are
managed by the Amazon IAM service. You can administer accounts directly in
the [Amazon Console](https://console.aws.amazon.com/iam/home?region=us-east-1).

IAM Users are able to access the AWS Console at the following URL:
https://391292630836.signin.aws.amazon.com/console.

## SSH Keys

SSH keys are stored directly in the MageCloudKit Git repository under the `ssh_keys` folder.
These keys are provisioned onto the App Servers when environments are created or
during the AMI baking process. You will need to add a User's public key here in order
for them to have access to the Bastion instance.

## MFA Tokens

For better security we recommend IAM accounts are secured using an
[MFA token](https://aws.amazon.com/iam/details/mfa/).

You will need to use a hardware device or install a software application such as
Google Authenticator on your smartphone. The source code for the latter is publicly
available if you wish to inspect it or compile from source.

Due to an AWS security limitation IAM roles cannot assume other IAM roles
without an MFA token.
