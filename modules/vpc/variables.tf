variable "vpc_cidr" {
  default = "192.168.1.0/24"
}
variable "vpc_tenancy" {
  default = "default"
}
variable "subnet_cidr_pub" {
  type = "list"
  default = ["192.168.1.0/26", "192.168.1.64/26"]
}
variable "subnet_cidr_pri" {
  type = "list"
  default = ["192.168.1.128/26", "192.168.1.192/26"]
}
data "aws_availability_zones" "azs" {}