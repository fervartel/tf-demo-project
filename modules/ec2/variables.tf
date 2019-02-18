variable "instance_count" {
  default = "1"
}
variable "ami" {
  default = "ami-0ac019f4fcb7cb7e6"
}
variable "ec2_subnet" {
  default = ""
}
variable "instance_type" {
  default = "t2.micro"
}
variable "ssh_key" {
  default = "fvarela-aws"
}