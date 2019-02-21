output "subnets_pri" {
    value = "${aws_subnet.tf-subnet-pri.*.id}"
}
output "subnets_pub" {
    value = "${aws_subnet.tf-subnet-pub.*.id}"
}