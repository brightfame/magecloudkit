---
title: Backups
---

## Databases

The databases are automatically backed up every hour by AWS and stored securely. They are kept for a
period of 7 days. This setting is configurable in the `rds.tf` Terraform file.

**Note:** Due to Amazon security policies it is not possible to access a database backup
directly. Instead you must either revert the RDS instance to the specific backup or
launch a new RDS instance based on the backup.

## Assets

The Wordpress and Magento assets are automatically backed up from the Elastic Filesystem to
an S3 bucket for the given environment. Please refer to the following buckets:

 * MageCloudKit-production-assets
 * MageCloudKit-staging-assets
