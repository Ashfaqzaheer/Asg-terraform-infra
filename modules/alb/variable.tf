variable "vpc_id" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "sg_id" {}
variable "tg_server_a" {}
variable "tg_server_b" {}
variable "tg_asg" {}

