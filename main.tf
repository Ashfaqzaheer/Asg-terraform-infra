provider "aws" {
  region = "ap-south-1"
}


module "vpc" {
  source                = "./modules/vpc"
  vpc_cidr              = "10.0.0.0/16"
  public_subnet_1a_cidr = "10.0.1.0/24"
}

module "internet_gateway" {
  source = "./modules/internet-gateway"

  vpc_id = module.vpc.vpc_id
  name   = "my-vpc-igw"
}

module "route_table" {
  source = "./modules/route_table"

  vpc_id             = module.vpc.vpc_id
  internet_gateway_id = module.internet_gateway.igw_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  name               = "public-route-table"
}



module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}


module "launch_template" {
  source            = "./modules/launch_template"
  security_group_id = module.security_group.security_group_id
  key_name          = var.key_name
}

module "auto_scaling_group" {
  source            = "./modules/auto_scaling_group"
  launch_template_id = module.launch_template.launch_template_id
  subnet_ids         = module.vpc.public_subnet_ids
}
