variable "launch_template_id" {
  description = "ID of the launch template"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for ASG"
  type        = list(string)
}
