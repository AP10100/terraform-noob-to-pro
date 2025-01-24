resource "aws_instance" "Terraform-EC2-Instance_demo" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = "Terraform-EC2-Instance"
  }
}