variable "security_group_id" {
  type        = string
  description = "ID of the security group to attach to the launch template"
}

variable "key_name" {
  type        = string
  description = "Name of the key pair to use for the EC2 instance"
}
