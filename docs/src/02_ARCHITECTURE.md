---
title: Architecture
---

The MageCloudKit architecture runs in the AWS Northern Virginia region (us-east-1) and is spread
across all three availability zones for high availability. It is designed to be both
performant and scalable.

We use the concept of environments also referred to as *workspaces* by Terraform.

We favour the concept of immutability which is a central tenet in the DevOps practice.
This concept is increasingly important as you begin to scale because it becomes
unmaintainable to SSH into servers and manually configure them.

## Rationale

AWS was chosen as due to the fact that it is the leader in cloud computing having
invented the industry. Amazon has also continuously lowered AWS costs since its
inception and gives us considerable room to grow our business.

We chose ECS over other services such as Kubernetes and Elastic Beanstalk for its
balance between flexibility and cost. In addition ECS scales great from a cluster
with 2 instances all the way up to 10,000. The logs are also streamed to CloudWatch
logs which gives a centralized overview.

## AWS Architecture

[![AWS Architecture](aws_architecture.png)](aws_architecture.png)

## Docker

Our architecture uses Docker to run all of our applications.

## Networking

Each environment launches resources inside an [Amazon VPC](https://aws.amazon.com/vpc/)
(virtual private network). Internally each environment has both a public and private
subnet. This is used for better network isolation and security.

We use Amazon NAT Gateway to allow the instances in the private subnet to connect to the
internet. The NAT gateways are available in each of the three availability zones.

## Server Roles

Our architecture utilizes the following server roles and instances:

 - Bastion: The Bastion instance runs in the public subnet and is used to access the resources inside the Amazon VPC. Refer to the SSH guide for more information.
 - App Servers: The App servers form the ECS cluster and run all of our Docker containers.

All of our EC2 instances are based on the Ubuntu 16.04 LTS (long-term support release). These instances
are hardened and have critical automatic software updates enabled.

### Bastion

The Bastion server is used to access resources running inside of the Amazon VPC.
You can SSH to the Bastion instance from the public internet. The server
also supports VPN connections. If you terminate a Bastion instance you will need to
generate and distribute the VPN keys again.

Please see the SSH & VPN section for more information.

### App Servers

These EC2 instances are part of an App Cluster (ECS cluster) that runs the applications.
They run the ECS agent which is responsible for starting Docker containers when
we deploy our code.

Deployments are handled by ECS by creating a new task definition then updating the
ECS service to use it. During a deployment ECS will start the new containers,
connect them to the load balancer then wait for them to become healthy before
terminating the old ones. You can check the current deployment's Git SHA hash
by accessing the `REVISION.txt` file:

    $ curl https://www.MageCloudKitusa.com/REVISION.txt

***Note:*** If the new containers remove static assets you may notice visual issues
during the deployment process.

## Cache

At present we run two Redis instances to store both the Magento cache and user
sessions.

## Database

At present all applications share the same RDS database cluster. The database is
powered by the [Amazon Aurora](https://aws.amazon.com/rds/aurora/details/mysql-details/)
product which can deliver up to a 5x increase in performance on the same hardware.
Amazon Aurora is a drop in replacement for MySQL and supports the same protocol
and tools. In addition Aurora uses the concept of clusters for better reliability
and performance.

### Database Properties

Our database runs on AWS RDS inside of our VPC. You can SSH via the Bastion host
or use a VPN connection in order to access it.

| Param         | Value                          |
| ------------- | ------------------------------ |
| Host          | db.MageCloudKit.internal              |
| Username      | magento2                       |
| Password      | check the ops code (`main.tf`) |
| Database      | magento2                       |

## Service Discovery

We utilize Route53 for a basic form of service discovery. We achieve this by using an
internal hosted zone with the following DNS records:

 * db.MageCloudKit.internal
 * redis-cache.MageCloudKit.internal
 * redis-session.MageCloudKit.interal
