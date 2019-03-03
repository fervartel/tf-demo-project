# Custom Security group - SSH
resource "aws_security_group" "tf-sg-ssh" {
  name        = "tf-sg-ssh"
  description = "Terraform created - Allow ssh inbound traffic"
  vpc_id      = "${aws_vpc.tf-vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-sg-ssh"
  }
}
# Generic EC2 instance
resource "aws_instance" "tf-instance" {
  count           = "${var.instance_count}"
  #ami            = "${var.ami}"
  ami             = "${data.aws_ami.ubuntu.id}" # Region agnostic
  instance_type   = "${var.instance_type}"
  subnet_id       = "${var.ec2_subnet}"
  security_groups = ["${var.ec2_sg}"]
  key_name 	      = "${var.ssh_key}"

  tags = {
    Name = "tf-instance-${count.index + 1}-${var.ec2_env}"
  }
}