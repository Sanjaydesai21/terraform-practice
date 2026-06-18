module "vpc" {
  source                 = "./module/vpc"
  vpc_cidr               = var.vpc_cidr
  public_subnet_1a_cidr  = var.public_subnet_1a_cidr
  public_subnet_az_1a    = var.public_subnet_az_1a
  public_subnet_2b_cidr  = var.public_subnet_2b_cidr
  public_subnet_az_2b    = var.public_subnet_az_2b
  private_subnet_1a_cidr = var.private_subnet_1a_cidr
  private_subnet_az_1a   = var.private_subnet_az_1a
  private_subnet_2b_cidr = var.private_subnet_2b_cidr
  private_subnet_az_2b   = var.private_subnet_az_2b

}

module "alb" {
  source                = "./module/alb"
  vpc_id                = module.vpc.vpc_id
  vpc_security_group_id = module.vpc.vpc_security_group_id
  public_subnet_1a_id   = module.vpc.public_subnet_1a_id
  public_subnet_2b_id   = module.vpc.public_subnet_2b_id
  private_subnet_1a_id  = module.vpc.private_subnet_1a_id
  private_subnet_2b_id  = module.vpc.private_subnet_2b_id
}

module "asg" {
  source                = "./module/asg"
  ami                   = var.ami
  instance_type         = var.instance_type
  key_name              = var.key_name
  vpc_security_group_id = module.vpc.vpc_security_group_id
  private_subnet_1a_id  = module.vpc.private_subnet_1a_id
  private_subnet_2b_id  = module.vpc.private_subnet_2b_id
  alb_tg_arn            = module.alb.alb_tg_arn
}
