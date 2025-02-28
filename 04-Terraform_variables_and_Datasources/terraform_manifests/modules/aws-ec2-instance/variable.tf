variable "ami_id" {
  description = "AMI ID for the instance"
  type        = string
}

variable "instance_type" {
  description = "Type of the instance"
  type        = string
}

variable "key_name" {
  description = "Key pair name for the instance"
  type        = string
}
