output "subnets_pri" {
    value = "${aws_subnet.tf-subnet-pri.*.id}"
}
output "subnets_pub" {
    value = "${aws_subnet.tf-subnet-pub.*.id}"
}
output "sg_ssh" {
    value = "${aws_security_group.tf-sg-ssh.id}"
}