resource "aws_instance" "Terraform-EC2-Instance_demo" {
  for_each = {
    dev-server = {
      ami           = var.ami_id
      instance_type = var.instance_type
      key_name      = var.key_name
    }
    test-server = {
      ami           = var.ami_id
      instance_type = var.instance_type
      key_name      = var.key_name
    }
    prod-server = {
      ami           = var.ami_id
      instance_type = var.instance_type
      key_name      = var.key_name
    }
  }

  ami           = each.value.ami           # Use the 'ami' from the map value
  instance_type = each.value.instance_type # Use the 'instance_type' from the map value
  key_name      = each.value.key_name

  tags = {
    Name = each.key                        # Use the key as the instance name
  }
}
