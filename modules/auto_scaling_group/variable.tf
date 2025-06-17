variable "subnet_ids" {
  type = list(string)
}

variable "launch_template_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "desired_capacity" {
  type = number
}
