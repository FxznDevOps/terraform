module "vpc" {
  source = "./module/vpc"

  vpc_cidr       = var.vpc_cidr
  vpc_name       = var.vpc_name
  public_subnet  = var.private_subnet
  azs            = var.azs
  private_subnet = var.public_subnet


}



module "ec2" {
  source = "./module/ec2"

  servername = "Webserver"
  ec2_ami    = "ami-08188a5a4dfdbd573"
  inst_type  = "t3.micro"
  subnet_id  = module.vpc.public_subnet_ids[0]
  vpc_id1    = module.vpc.vpc_id
  ingress_rules = [
    { port = "22", protocol = "tcp", cidr_blocks = "0.0.0.0/32" },
    { port = "80", protocol = "tcp", cidr_blocks = "0.0.0.0/32" },
  ]



}


module "ec2_2" {
  source = "./module/ec2"

  servername = "bastion"
  ec2_ami    = "ami-08188a5a4dfdbd573"
  inst_type  = "t3.micro"
  subnet_id  = module.vpc.public_subnet_ids[1]
  vpc_id1    = module.vpc.vpc_id
  ingress_rules = [
    { port = "22", protocol = "tcp", cidr_blocks = "0.0.0.0/0" }
  ]



}



module "db" {
  source = "./module/ec2"

  servername = "db"
  ec2_ami    = "ami-08188a5a4dfdbd573"
  inst_type  = "t3.micro"
  subnet_id  = module.vpc.private_subnet_ids[1]
  vpc_id1    = module.vpc.vpc_id
  ingress_rules = [
    { port = "3306", protocol = "tcp", cidr_blocks = "0.0.0.0/0" }
  ]



}
