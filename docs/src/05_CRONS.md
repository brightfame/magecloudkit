---
title: Crons
---

Cron jobs run both the Magento 2 indexer and cron commands. The crons
run inside Docker containers on the App Cluster and are triggered using
CloudWatch events. The ECS task definitions for the cron jobs are stored
in the `cron.tf` file.

## Running one off tasks

If you need to manually run a task or cron job you can use the ECS Run
Task functionality. For example to run the Magento 2 installer:

    $ aws ecs run-task --cluster production-app --task-definition production-magento2-setup:1

### Multiple Stuck Cron Jobs

You can use the `admiral` tool to identify which instances the cron jobs are running on:

    $ admiral tasks list production-app

Then it may simply be a matter of terminating the associated EC2 instance and allowing the Autoscaling group to recreate it.

    $ aws ec2 terminate-instances --instance-ids i-041a5028868a0a122
