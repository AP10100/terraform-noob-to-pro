output "instance_id" {
  value = { for k, v in aws_instance.Terraform-EC2-Instance_demo : k => v.id }
}

output "public_ip" {
  value = { for k, v in aws_instance.Terraform-EC2-Instance_demo : k => v.public_ip }
}
