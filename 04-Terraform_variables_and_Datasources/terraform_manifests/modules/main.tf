terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

module "ec2_instance" {
  source        = "./modules/aws-ec2-instance"
  instance_type = "t2.micro"
  ami_id        = "ami-005fc0f236362e99f" # Replace with the desired AMI ID
  key_name      = "Terra_eks_key"               # Replace with your key pair
}

output "instance_id" {
  value = module.ec2_instance.instance_id
}

output "public_ip" {
  value = module.ec2_instance.public_ip
}
