---
title: Scaling
---

Our scaling implementation is based on the [AWS Autoscaling](https://aws.amazon.com/autoscaling/)
product. We use Autoscaling to scale up in periods of high traffic and scale down
to reduce costs. Autoscaling is also used for redundancy purposes to replace
failed containers and instances.

## Manually Scaling

If you need to manually scale and add additional capacity you can adjust the following
variable values:

 * *app_server_count*: Refers to the number of App Servers (EC2 instances) that form the App Cluster.
 * *app_task_count*: Refers to the number of App Tasks run by the ECS service.

 These variables are located in the `main.tf` Terform file and are configured independently
 for each environment. After changing the values you will need to run the Terraform plan
 and apply commands.

**Note:** The App Server count must exceed the App Task count. When creating a new Autoscaling
group for the App Cluster the task count should be equal to two times the App Server count. This is
necessary so the new instances pass the load balancer health checks.
