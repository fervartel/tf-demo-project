resource "aws_instance" "tf-instance" {
  count         = "${var.instance_count}"
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  subnet_id     = "${var.ec2_subnet}"
  key_name 	    = "${var.ssh_key}"

  tags = {
    Name = "tf-instance-${count.index+1}"
  }
}