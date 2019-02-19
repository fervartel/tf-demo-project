provider "aws" {
/*
  # Static credentials setup (not recommended)   
  access_key = "YOUR ACCESS_KEY"
  secret_key = "YOUR SECRET_KEY"
 */

  # Shared credentials file setup (default file: $HOME/.aws/credentials).
  #   'profile' argument is used when multiple accounts are managed in the same file
  profile   = "${var.aws_profile}"   # Look for the profile in the shared credentials file (e.g. ~/.aws/credentials)
  region    = "${var.aws_region}"
}
# Terraform backend definition to store the "tfstate" remotely in S3
/*
terraform {
  backend "s3" {
    bucket          = "mybucket"
    key             = "tf-demo-project/dev/terraform.tfstate"
    region          = "us-east-1"
    # This is used to lock concurrent apply operations. It requires
    # a DynamoDB table created with the name as below with a primary 
    # key named "LockID"
    dynamodb_table  = "terraform_state" 
  }
}
*/

# Creation of VPC and associated network features
module "dev-vpc" {
    source      = "../modules/vpc"
    /*
    vpc_cidr    = "10.0.0.0/16"
    tenancy     = "default"
    subnet_cidr_pub = ["10.0.0.0/24", "10.0.1.0/24"]
    subnet_cidr_pri = ["10.0.2.0/24", "10.0.3.0/24"]
    */
}

# Creation of EC2 instance
/* 
module "dev-ec2" {
    source          = "../modules/ec2"
    
    #instance_count  = 1
    #ami             = "ami-0ac019f4fcb7cb7e6"
    #instance_type   = "t2.micro"
    #ssh_key         = "fvarela-aws"

    ec2_subnet      = "${module.dev-vpc.subnets_pub[0]}"
} */