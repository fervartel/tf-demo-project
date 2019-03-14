provider "aws" {
/*
  # Static credentials setup (not recommended)   
  access_key = "YOUR ACCESS_KEY"
  secret_key = "YOUR SECRET_KEY"
 */

  # Shared credentials file setup (default file: $HOME/.aws/credentials).
  #   'profile' argument is used when multiple accounts are managed in the same file
  #shared_credentials_file = "${var.aws_shared_cred}"
  profile   = "${var.aws_profile}"   # Variable to search the profile in the shared credentials file (e.g. ~/.aws/credentials)
  region    = "${var.aws_region}"
}
# Terraform backend definition to store the "tfstate" remotely in S3
/* terraform {
  backend "s3" {
    bucket          = "fvarela-terraform-temp"
    key             = "tf-demo-project/prod/terraform.tfstate"
    region          = "us-east-1"
    # This is used to lock concurrent apply operations. It requires
    # a DynamoDB table created with the name as below with a primary 
    # key named "LockID"
    dynamodb_table  = "terraform_state_prod" 
  }
} */

# Creation of VPC and associated network features
module "prod-vpc" {
    source      = "../../../tf-modules/vpc"
    vpc_env         = "prod"
    vpc_cidr    = "192.168.0.0/24"
    vpc_tenancy     = "default"
    subnet_cidr_pub = ["192.168.0.0/26", "192.168.0.64/26"]
    subnet_cidr_pri = ["192.168.0.128/26", "192.168.0.192/26"]
}

# Creation of EC2 instance
 
module "prod-ec2-pub" {
    source          = "../../../tf-modules/ec2"
    ec2_env         = "prod"

    #instance_count  = 1
    #instance_type   = "t2.micro"
    #ssh_key         = "fvarela-aws"

    #ami             = "ami-0ac019f4fcb7cb7e6"  # By default it'll resolve from ubuntu Data Source

    ec2_subnet      = "${module.prod-vpc.subnets_pub[0]}"
    ec2_sg          = "${module.prod-vpc.sg_ssh}"
}