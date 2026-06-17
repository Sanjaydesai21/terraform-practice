module "vpc" {
  source                 = "./module/vpc"
  vpc_cidr               = "10.0.0.0/16"
  public_subnet_1a_cidr  = "10.0.0.0/24"
  public_subnet_az_1a    = "ap-south-1a"
  public_subnet_2b_cidr  = "10.0.1.0/24"
  public_subnet_az_2b    = "ap-south-1b"
  private_subnet_1a_cidr = "10.0.2.0/24"
  private_subnet_az_1a   = "ap-south-1a"
  private_subnet_2b_cidr = "10.0.3.0/24"
  private_subnet_az_2b   = "ap-south-1b"

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
  ami                   = "ami-01a00762f46d584a1"
  instance_type         = "t2.micro"
  key_name              = "mykey"
  vpc_security_group_id = module.vpc.vpc_security_group_id
  private_subnet_1a_id  = module.vpc.private_subnet_1a_id
  private_subnet_2b_id  = module.vpc.private_subnet_2b_id
  alb_tg_arn            = module.alb.alb_tg_arn
}
