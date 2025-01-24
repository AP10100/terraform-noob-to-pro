# Terraform Settings, Providers & Resource Blocks

step: i --------------
1. Terraform Settings block
https://www.terraform.io/docs/language/settings/index.html

2. Terraform Provider block
https://www.terraform.io/docs/providers/index.html

3. Terraform Resource block
https://www.terraform.io/docs/language/resources/index.html


step: ii -------------
1. In versions.tf - Created Terraform Settings Block
terraform {
  required_version = ">= 1.2.0"
  required_providers {
    aws = {
         source = "hashicorp/aws"
         version = "~> 4.16 "
    }
  }
}


2. 1. In versions.tf - Created Terraform Provider Block

Configure AWS Credentials in the AWS CLI if not configured
# Verify AWS Credentials
cat $HOME/.aws/credentials

provider "aws" {
   profile = "default"
   region = "us-east-1"
}


3. In ec2instance.tf - Create Resource Block
resource "aws_instance" "terra_demo_machine" {
   ami = "ami-005fc0f236362e99f"
   instance_type = "t2.micro"
   key_name = "N.virg_demo_key"
   user_data = file("${path.module}/app1-install.sh")
   tags = {
     "Name" = "EC2_Terra_demo"
   }
}


4. Review file app1-install.sh

#! /bin/bash
# Instance Identity Metadata Reference - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-identity-documents.html
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start  
sudo echo '<h1>Welcome to StackSimplify - APP-1</h1>' | sudo tee /var/www/html/index.html
sudo mkdir /var/www/html/app1
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Stack Simplify - APP-1</h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app1/index.html
sudo curl http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/app1/metadata.html


5. Execute Terraform Commands
terraform init
terraform validate
terraform plan
terraform apply -y


6. Access Application
public-ip:port

7. Terraform state
check the docs.





