---
title: Disaster Recovery
---

This guide outlines the steps required in an emergency situation such as the loss
of a production facing application.

The best advice during downtime is to not touch anything and wait for the
architecture to heal itself. We use hosted RDS with the Multi-AZ feature enabled,
Autoscaling groups for our application servers and Amazon ECS to run our
application containers.

* In the event of a database failure, RDS will automatically fail-over to the standby database running in a separate availability zone.
* In the event of an application server failure, the Autoscaling group will automatically launch a new instance.
* In the event of an ECS container failure, the ECS service will automatically launch a new container.

However in certain situations additional steps may need to be taken.

## Manually Recreating a Failed Application Server

First check where the ECS tasks are running using the Admiral tool:

    $ admiral tasks list production-app

Then terminate the instance and allow the Autoscaling group to create a new one.
You can do this using the AWS CLI tool:

    $ aws ec2 terminate-instances —instance-ids i-200000000000

Once the instance is removed from the load balancer, the Autoscaling group will
launch a new one within 5-10 minutes.

## Investigating a Server manually

Common server problems include lack of free space and/or disk inodes. You can
check the status of these with:

    $ df
    $ df -i

or available memory with:

    $ free -m

The `htop` utility provides a good overview of the instance resources:

    $ htop

## Restoring an RDS Database Snapshot

If you manually need to restore an RDS database snapshot, you can follow these steps:

1. Launch a new RDS database from the snapshot using the AWS console.
2. After the RDS database is available export the database using the MySQL client tools from one of the App Servers.
3. You can then import this database dump into the primary database cluster.
4. Next, drop and recreate the existing application database using the MySQL console.
5. You can then import the database dump into the primary database cluster.

An example list of commands would be:

    $ mysqldump -h <RDS_HOST_IP> -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE > dbbackup-$(date +%Y%m%d-%H%M%S).sql
    $ mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE
    DROP DATABASE magento2;
    CREATE DATABASE magento2;
    $ mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE < dbbackup-20180101000000.sql

**Note:** Dropping the database will incur application downtime.
