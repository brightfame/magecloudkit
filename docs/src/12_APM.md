---
title: APM
---

Application Performance Management (or APM) refers to the monitoring and management of
performance and availability of software applications. MageCloudKit uses APM vendors to
identify performance bottlenecks and windows of downtime.

## Metrics

The CPU and memory metrics are monitored using the AWS ECS and CloudWatch products.

## Bug Error Tracking

MageCloudKit uses [Bugsnag](https://www.bugsnag.com/) to track application
exceptions. Bugsnag can also be used to calculate the error rate.
Exceptions from every application, long running process or cron job
are automatically sent to and tracked by Bugsnag.

## Pingdom

[Pingdom](https://www.pingdom.com/) is used to monitor the applications
and validate the SSL certificates. At present the alerting is  sent via SMS to
Rob's phone. This can be changed as required in the Pingdom web interface.

**Note:** It is important to use a 3rd party monitoring service in the event an
entire AWS region becomes unavailable.

## Datadog

We use [Datadog](https://www.datadoghq.com) to monitor the overall health and performance
of the infrastructure through several dashboards and alerts. Datadog agents are
also installed on each instance.
