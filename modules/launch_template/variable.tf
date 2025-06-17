variable "security_group_id" {
  type        = string
  description = "ID of the security group to attach to the launch template"
}

variable "key_name" {
  type        = string
  description = "Name of the key pair to use for the EC2 instance"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}