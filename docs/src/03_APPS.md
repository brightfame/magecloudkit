---
title: Apps
---

Apps run on the App Cluster and are built according to [12factor](https://12factor.net) principles.
An App can be comprised of one or more Docker containers and is described by an
[ECS task definition](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definitions.html).
The MageCloudKit architecture only runs a single application, namely the Magento 2 app.

## App Cluster

The App Cluster runs on top of the [Amazon Elastic Container](https://aws.amazon.com/ecs/) service
and is comprised of all of the App Servers.

## Magento 2 App

The Magento 2 App actually comprises both the Magento 2 and Wordpress applications.

The App is comprised of the following containers:

 * Nginx webserver: To serve static assets and reverse proxy requests to the PHP-FPM container.
 * PHP-FPM: To run the Magento 2 and Wordpress applications.
 * Blackfire: For continuous performance testing.

MageCloudKit runs the Magento Open Source 2.2 software.
