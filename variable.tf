variable "key_name" {
  type        = string
  description = "Key pair name to use for EC2 instances"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}
