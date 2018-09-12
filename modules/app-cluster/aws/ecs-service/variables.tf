# AWS region variable
variable "aws_region" {
	description = "Helps dynamicly define the AWS region"
}

# AWS provider version definition
variable "aws_provider_version" {
	description = "Helps set the AWS Terraform provider version"
	defult = "~> 1.22"
}