variable "instance_count" {
  default = "1"
}
/* variable "ami" {
  default = "ami-0ac019f4fcb7cb7e6"
} */
variable "ec2_subnet" {
  default = ""
}
variable "instance_type" {
  default = "t2.micro"
}
variable "ssh_key" {
  default = "fvarela-aws"
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    #values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-20180912"] # Free Tier
  }

  owners = ["099720109477"] # Canonical
}