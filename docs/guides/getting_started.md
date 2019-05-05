# Getting Started

This guide explains how to setup and deploy a new MageCloudKit environment.

## Requirements

Before we get started you should have the following tools installed locally:

- [Terraform](https://www.terraform.io) v0.11.10
- [Packer](https://www.packer.io) v1.3.2
- `awscli`

As MageCloudKit requires Amazon EFS, only the following AWS regions are supported:

- us-east-1
- us-east-2
- us-west-1
- us-west-2
- eu-central-1
- eu-west-1
- ap-northeast-1
- ap-northeast-2
- ap-southeast-1
- ap-southeast-2

## Recommended Configurations

3000+ visitors per day
1000,000 orders per day
