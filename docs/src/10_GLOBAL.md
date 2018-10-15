---
title: Global Environment
---

The global environment was created manually in the AWS console and is not managed
by Terraform. It is responsible for any resources that should be shared between
the discrete environments including: IAM roles and the Elastic Container Registry.

 * An IAM user used by CircleCI for the purposes of continuous integration,
 * An IAM policy used by Datadog for the purposes of monitoring,
 * The `MageCloudKit-ops` and `MageCloudKit-state` S3 buckets for storing shared resources and Terraform state
 * And multiple Amazon ECR repositories for storing the Docker images.

The IAM CircleCI user has a limited set of credentials that allow the service to
push Docker images into the container registry.

These can be modified in CircleCI in the environment variables section under 'Settings'.

* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY
