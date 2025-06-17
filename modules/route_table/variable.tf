variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  type        = string
}

variable "public_subnet_ids" {
  type = map(string)
}


variable "name" {
  description = "Name tag for the route table"
  type        = string
}
