variable "ami_id" {
  default = "ami-80861296"
}

resource "aws_security_group" "web" {
  name = "vpc_web"
  description = "Security group for web microservice"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
  }

  ingress {
    from_port = -1
    to_port = -1
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "icmp"
  }
}

resource "aws_launch_configuration" "web-lc" {
  image_id = "${var.ami_id}"
  instance_type = "m4.large"
  security_groups = ["${aws_security_group.web.id}"]
  user_data = "${file("user_data/web-server.sh")}"
  key_name = "cody"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elb" "web-elb" {
  name = "web-elb"
  subnets = ["${aws_subnet.us-east-1a-public.id}"]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 5
    timeout = 5
    target = "HTTP:80/"
    interval = 30
  }
}

resource "aws_autoscaling_group" "web" {
  name = "web_asg"
  max_size = 4
  min_size = 2
  desired_capacity = 2
  health_check_grace_period = 300
  health_check_type = "ELB"
  vpc_zone_identifier = ["${aws_subnet.us-east-1a-public.id}"]
  launch_configuration = "${aws_launch_configuration.web-lc.id}"
  load_balancers = ["${aws_elb.web-elb.id}"]
  lifecycle {
    create_before_destroy = true
  }
}
