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
   public_subnet_ids = {
    subnet-1 = module.vpc.public_subnet_ids[0]
    subnet-2 = module.vpc.public_subnet_ids[1]
  }
  name               = "public-route-table"
}



module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}


module "launch_template" {
  source            = "./modules/launch_template"
  security_group_id = module.security_group.security_group_id
   ami_id         = var.ami_id
  instance_type  = var.instance_type
  key_name          = var.key_name
}

module "auto_scaling_group" {
  source = "./modules/auto_scaling_group"

  subnet_ids          = module.vpc.public_subnet_ids
  launch_template_id  = module.launch_template.launch_template_id
  target_group_arn    = module.target_group.tg_asg_arn  # <- This is what was missing

  min_size            = 1
  max_size            = 4
  desired_capacity    = 2
}


module "ec2" {
  source           = "./modules/ec2"
  vpc_id           = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  sg_id            = module.security_group.security_group_id
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  sg_id             = module.security_group.security_group_id
  tg_server_a       = module.target_group.tg_server_a
  tg_server_b       = module.target_group.tg_server_b
  tg_asg            = module.target_group.tg_asg
}

module "target_group" {
  source    = "./modules/target_group"
  vpc_id    = module.vpc.vpc_id
  ec2_a_id  = module.ec2.ec2_a_id
  ec2_b_id  = module.ec2.ec2_b_id
}