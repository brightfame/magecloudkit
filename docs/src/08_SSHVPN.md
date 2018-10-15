---
title: SSH & VPN
---

MageCloudKit uses a Bastion server for SSH access with a public IP address. It is also
used as a VPN host. You can use this instance as a jump server from the internet
to connect to resources inside the Amazon VPC.

In order to access this server you must use the shared private SSH key (`private/deployer.pem`).
You can optionally add your own SSH key under `ssh_keys` to have it provisioned
onto an instance when it is created. We disable SSH Password Authentication for
security purposes.

## SSH via the Bastion instance

You should connect to the Bastion instance with key forwarding enabled. This
allows one to further connect to private resources inside the AWS VPC.

To connect to an application server, first connect to the bastion instance:

    $ ssh -A -i private/deployer.pem ubuntu@bastion_ip

And then connect again to an application instance:

    $ ssh app_private_ip

## SSH via the VPN

We have included a number of bash helper scripts to assist with creating and
managing user accounts. To be able to use these scripts you will need to know
the master VPN key. This key is stored on the MageCloudKit Ops S3 bucket.

The Bastion instance runs the OpenVPN software so a compatible client will need
to be installed on your computer. We use Viscosity and Tunnelblick on macOS and
the official OpenVPN client on [Windows and Linux](https://openvpn.net/index.php/open-source/downloads.html).

### Creating new VPN accounts

In order to create new VPN accounts you will need access to the master VPN key.

To create a new VPN simply use the included bash script:

    $ ./ops/bin/ovpn-new-client.sh --env production --client MageCloudKit-production-username

The username should follow the convention of the first letter of your firstname,
followed by your full surname. For example: `rmorgan` or `aibrahim`.

Now fetch the VPN configuration by running:

    $ ./ops/bin/ovpn-client-config.sh --env production --client MageCloudKit-production-username

This will download the OpenVPN configuration to your current local directory.
Import this file into your VPN client in order to connect to the AWS VPC. You can
test your connection by trying to ping an EC2 instance with a private IP address.

**Note:** The OpenVPN config will be generated with the instance Public IP address however if you are using an Elastic IP you will need to edit the config file before importing it and change the address.

### Removing VPN accounts

To a remove/revoke a VPN account simply use the following script:

    $ ./ops/bin/ovpn-revoke-client.sh --env production --client MageCloudKit-production-username

You will also need to supply the master VPN key twice to complete the process.
