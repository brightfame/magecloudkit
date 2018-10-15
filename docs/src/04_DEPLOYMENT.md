---
title: CI & Deployment
---

The MageCloudKit code is packaged into Docker images by CircleCI, then deployed to the
App Cluster following a rolling deployment model. This ensures there is no downtime
during the deployment process.

**Note:** This section refers to continuous integration and code deployment. If
you are looking to modify infrastructure then refer to the Infrastructure section.

## The Build Process

When a new branch or commit is pushed to GitHub a webhook will automatically trigger
a new build on CircleCI. CircleCI is responsible for building the Docker images and
then pushing them to a registry hosted on Amazon ECR. As a DevOps best practice -
both the staging and production environments are design to run the same Docker images.

## The Deployment Process

When we are ready to deploy the application a developer uses the `ecs-deploy.sh` script
to create a new task definition and update the ECS service.

Here is an example:

    $ ./bin/ecs-deploy.sh -c production-app -n production-app -to <build_id> -i ignore -t 360

Where `<build_id>` would be substituted with the CircleCI build number. Deploying a new build
will automatically execute the Magento `setup:upgrade` and `cache:flush` commands.

After deploying your code you should refer to the APM section for monitoring it.

More information on Magento 2.2 deployment is available here: http://devdocs.magento.com/guides/v2.2/config-guide/deployment/.

## Adding a new project on CircleCI

You can add a new project using the CircleCI Web UI. You will just need to ensure
the following environment variables are set:

 * AWS_REGION=eu-west-1
 * AWS_ACCESS_KEY_ID=foo
 * AWS_SECRET_ACCESS_KEY=bar
 * AWS_ECR_URL=738390193670.dkr.ecr.eu-west-1.amazonaws.com

The AWS IAM credentials should be for the `CircleCI` user. A copy of these credentials can be found
on the `MageCloudKit-ops` S3 bucket.

CircleCI has a feature where you can copy the environment variables from an already configured project.

## Manually Building the Docker Images

First get the repository URL as we'll need it for the next step:

    $ make get-ecr

Ensure Docker is running then run the following commands:

    $ make composer
    $ make precompile
    $ make build BUILD_NUM=latest
    $ make push BUILD_NUM=latest AWS_ECR_URL=111111111111.dkr.ecr.us-east-1.amazonaws.com

**Note:** Be sure to substitute your registry URL in the `AWS_ECR_URL` variable.

**Note:** If the command fails make sure you haven't previously generated an `env.php` (`magento/app/etc/env.php`) file.

**Note:** You can refer to the commands in the `.circleci/config.yml` file as a reference.

## Environment Variables

Environment variables including secrets for the containers are directly stored in the ECS task definitions.

## Post Deployment Cleanup

The only real necessary task is to keep an eye on the Elastic Container Register (ECR) image count.
The ECR service can only store 1000 container images and will need to be occasionally garbage collected.
Also you might want to delete your local and remote Git branches too before they go stale.
