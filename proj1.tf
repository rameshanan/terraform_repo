provider "aws" {
  access_key = "AKIAJO4DQO6NCAJGDUUQ"
  secret_key = "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"
  region     = "us-east-1"
}
resource "aws_elb" "apachephp" {
  name  = "terraform-elb"
  security_groups = ["${aws_security_group.SG_ec2.id}"]
  availability_zones = ["us-east-1a" , "us-east-1b"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.php"
    interval            = 30
  }

  tags = {
    Name = "terraform-elb"
  }
}
resource "aws_security_group" "SG_ec2" {
  vpc_id = "${var.VPC_id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "SG_ec2"
  }
}
resource "aws_security_group" "SG_elb" {
  vpc_id = "${var.VPC_id}"

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }
  tags {
    Name = "SG_elb"
  }
}
resource "aws_instance" "ec2" {
  ami           = "ami-2757f631"
  key_name = "ram"
  instance_type = "t2.micro"
subnet_id = "${var.subnet_id}"
  
  user_data = "${file("userdata.sh")}"
  tags {
    Name = "ec2_terraform"
  }
}
