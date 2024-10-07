provider "aws" {
  region = "us-east-1"
}


module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  az                  = "us-east-1a"
}

module "security_groups" {
  source                  = "./modules/security_groups"
  vpc_id                  = module.vpc.vpc_id
  allowed_ip              = "192.168.1.1/32"
  public_security_group_id = "sg-12345678" # Replace with the actual security group ID
}







module "ec2" {
  source                = "./modules/ec2"
  ami                   = "ami-04b3c39a8a1c62b76"
  instance_type         = "t2.micro"
  public_subnet_id      = module.vpc.public_subnet_id
  private_subnet_id     = module.vpc.private_subnet_id
  public_security_group = module.security_groups.public_security_group_id
  private_security_group = module.security_groups.private_security_group_id
}


