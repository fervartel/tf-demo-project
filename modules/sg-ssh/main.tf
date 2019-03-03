# Custom Security group - SSH
resource "aws_security_group" "tf-sg-ssh" {
  name        = "tf-sg-ssh"
  description = "Terraform created - Allow ssh inbound traffic"
  #vpc_id      = "${aws_vpc.tf-vpc.id}"
  vpc_id      = "${var.sg_vpc_id}"

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