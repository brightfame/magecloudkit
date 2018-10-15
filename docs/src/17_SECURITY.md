---
title: Security
---

As we rely on two major open source projects it is imperative to constantly
monitor and apply security patches as they are generally released. This is handled
by MageCloudKit team on a monthly basis.

**Note:** It is strongly recommended that developers use a MFA token associated with
their AWS IAM account and a service for securely storing credentials locally such as
[aws-vault](https://github.com/99designs/aws-vault). More information on MFA tokens can
be found in the Users section.

## Security Checklist

This resource serves as a very handy primer: https://www.sqreen.io/checklists/saas-cto-security-checklist.

## Security Updates

Security updates should be applied in a swift manner according to the relative threat level and
associated risks.

### Ubuntu Linux Updates

The EC2 instances are based on Ubuntu Linux. They have automatic updates enabled for critical
security fixes. However if for any reason you wish to update an instance manually, you can
simply run the following commands:

    $ sudo apt-get update
    $ sudo unattended-upgrades -d

The App Servers should be rebuilt using the baking instructions described in the Deployment section.

### Magento Updates

Please refer to the following URL: https://magento.com/security.

### Wordpress Updates

Please refer to the following URL: https://wordpress.org/news/category/security/.

## Cloudflare & DDoS Protection

We use the [Cloudflare](https://www.cloudflare.com/) service for content acceleration and
DDoS protection. The single user login is available in the MageCloudKit credentials spreadsheet.
