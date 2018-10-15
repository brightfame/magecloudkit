---
title: Logging
---

The application logs are stored and indexed using the AWS CloudWatch Logs product. Each
application container is configured to use a separate CloudWatch log stream. The
logs are stored for a maximum of 30 days. This setting is configurable in the
Terraform configuration code.

## Viewing the Logs in the AWS Console

1. Simply login into the AWS Console using your account and navigate to the CloudWatch product.
2. Select 'Logs' from the left hand side-bar.
3. Logs are stored on a per-environment basis.

[![AWS CloudWatch Logs](aws_cloudwatch_logs.jpg)](aws_cloudwatch_logs.jpg)

## Tailing the logs using the awslogs utility

The `awslogs` utility is more powerful that the CloudWatch Logs web interface, but must be run from the command line. You can
easily tail a log group or stream with the following command:

    $ awslogs get production-app -w

For a full list of commands review the output of the help command:

    $ awslogs --help
