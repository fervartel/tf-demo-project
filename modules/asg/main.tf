resource "aws_launch_template" "tf-launch-template" {
  name_prefix     = "tf-lt-"
  image_id        = "${data.aws_ami.ubuntu.id}"
  instance_type   = "${var.instance_type}"
  key_name 	      = "${var.ssh_key}"
  vpc_security_group_ids = ["${var.security_groups}"]

  tags = {
      Name = "tf-launch-template"
    }
}

resource "aws_autoscaling_group" "tf-asg" {
  name                  = "tf-asg"
  desired_capacity      = 2
  min_size              = 2
  max_size              = 4
  vpc_zone_identifier   = ["${var.subnets[0]}", "${var.subnets[1]}"]

  launch_template {
    id      = "${aws_launch_template.tf-launch-template.id}"
    version = "$$Latest"
  }
  lifecycle {
    create_before_destroy = true
  }
}