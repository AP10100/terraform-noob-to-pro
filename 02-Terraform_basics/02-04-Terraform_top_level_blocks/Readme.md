# typical file structure in terraform to write code that have modularity, reusability, and best practices 

root/
├── main.tf           # Calls the module and references its outputs
├── variables.tf      # Define root-level input variables
├── outputs.tf        # Outputs from root module (optional)
├── modules/
│   └── ec2/
│       ├── main.tf   # Resources for the EC2 module
│       ├── variables.tf # Input variables for the EC2 module
│       └── outputs.tf   # Outputs from the EC2 module


# Most of the terraform feature are implemented as top-level block....

# we categories terraform top-level blocks to 3 different parts

1. Understand about Terraform Top-Level Blocks

i. Fundamental blocks
Terraform Settings Block
Provider Block
Resource Block

ii. Variable blocks
Input Variables Block
Output Values Block
Local Values Block

iii. Calling / Referencing blocks
Data Sources Block
Modules Block

--------------------------------------------------------------------------------------------------------------

we can take same example fo this one also that we have no of block n the code like for..

# Terraform Setting Block:
terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.31"
    }
  }


# Provider Block:
provider "aws" {
  profile = "default" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region  = "us-east-1"
}


# Resource Block:
resource "aws_instance" "ec2demo" {
  ami           = "ami-04d29b6f966df1537" # Amazon Linux
  instance_type = var.instance_type
}


# Input Variables Block:
variable "instance_type" {
  default = "t2.micro"
  description = "EC2 Instance Type"
  type = string
}


# Output Values Block:
output "ec2_instance_publicip" {
  description = "EC2 Instance Public IP"
  value = aws_instance.my-ec2-vm.public_ip
}


# Local Values Block:
# Create S3 Bucket - with Input Variables & Local Values
locals {
  bucket-name-prefix = "${var.app_name}-${var.environment_name}"
}

# Data Sources Block:
data "aws_ami" "amzlinux" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


# Modules Block



.
