provider "aws" {
  region = var.region
  profile = "felipe"
}

module "vpc" {
  source = "./modules/vpc"
}

module "network" {
  source = "./modules/network"

  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "./modules/ec2"

  vpc_id          = module.vpc.vpc_id
  subnet_private1 = module.network.private_subnet_1
  subnet_private2 = module.network.private_subnet_2
  public_subnet   = module.network.public_subnet
  s3_bucket_arn = module.s3.s3_bucket_arn
}

module "s3" {
  source = "./modules/s3"
}