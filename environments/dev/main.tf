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
    key             = "tf-demo-project/dev/terraform.tfstate"
    region          = "us-east-1"
    # This is used to lock concurrent apply operations. It requires
    # a DynamoDB table created with the name as below with a primary 
    # key named "LockID"
    dynamodb_table  = "terraform_state_dev" 
  }
} */
# Creation of VPC and associated network features
module "dev-vpc" {
    source      = "../../modules/vpc"
    vpc_env         = "dev"
    
    vpc_cidr    = "192.168.1.0/24"
    vpc_tenancy     = "default"
    subnet_cidr_pub = ["192.168.1.0/26", "192.168.1.64/26"]
    subnet_cidr_pri = ["192.168.1.128/26", "192.168.1.192/26"]
   
}
# Creation of SSH SG
module "dev-sg-ssh" {
    source      = "../../modules/sg-ssh"
    
    sg_vpc_id   = "${module.dev-vpc.vpc_id}"
}
# Creation of HTTP-HTTPS SG
module "dev-sg-http" {
    source      = "../../modules/sg-http"
    
    sg_vpc_id   = "${module.dev-vpc.vpc_id}"
}
# Creation of an Application Load Balancer
module "dev-elb" {
    source          = "../../modules/elb"
    
    elb_vpc_id          = "${module.dev-vpc.vpc_id}"
    elb_target_type     = "instance"
    elb_protocol        = "HTTP"
    elb_port            = "80"
    elb_scheme_internal = "false"       #Internet facing
    elb_type            = "application"
    elb_sg              = ["${module.dev-sg-http.sg_http}"]
    elb_sn              = ["${module.dev-vpc.subnets_pub[0]}", "${module.dev-vpc.subnets_pub[1]}"]
}

# Creation of Auto-Scaling Group
module "dev-asg" {
    source              = "../../modules/asg"
    
    instance_type       = "t2.micro"
    ssh_key             = "fvarela-aws"
    security_groups     = ["${module.dev-sg-ssh.sg_ssh}", "${module.dev-sg-http.sg_http}"]
    subnets             = ["${module.dev-vpc.subnets_pub[0]}", "${module.dev-vpc.subnets_pub[1]}"]
    asg_lb_target_group =["${module.dev-elb.elb_tg_arn}"]}

# # Creation of MySQL SG
# module "dev-sg-mysql" {
#     source      = "../../modules/sg-mysql"
    
#     sg_vpc_id   = "${module.dev-vpc.vpc_id}"
# }
# # Creation of DB Subnet Group
# module "dev-db-sn-grp" {
#     source            = "../../modules/db-sn-grp"
#     db-sn-grp_env     = "dev"

#     db-sn-grp_subnets = "${module.dev-vpc.subnets_pub}"
# }
# # Creation of RDS MySQL DB
# module "dev-rds-mysql" {
#     source              = "../../modules/rds-mysql"
#     rds-mysql_env       = "dev"

#     rds-mysql_db-sn-grp = "${module.dev-db-sn-grp.db_sn_grp}"
#     rds-mysql_sg        = "${module.dev-sg-mysql.sg_mysql}"
# }

# # Creation of Single EC2 instance
# module "dev-ec2-pub" {
#     source          = "../../modules/ec2"
#     ec2_env         = "dev"

#     #instance_count  = 1
#     #instance_type   = "t2.micro"
#     #ssh_key         = "fvarela-aws"

#     #ami             = "ami-0ac019f4fcb7cb7e6"  # By default it'll resolve from ubuntu Data Source

#     ec2_subnet      = "${module.dev-vpc.subnets_pub[0]}"
#     ec2_sg          = "${module.dev-sg-ssh.sg_ssh}"
# }