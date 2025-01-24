output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.Terraform-EC2-Instance_demo.id
}

output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.Terraform-EC2-Instance_demo.public_ip
}
