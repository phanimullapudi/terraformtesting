terraform {
  backend "s3" {}
}

resource "aws_elb" "example" {
    name                = "${var.cluster_name}-elb"
    availability_zones  = ["us-west-2a", "us-west-2b"]
    security_groups     = ["${aws_security_group.elb.id}"]


    listener {
        lb_port             = 80
        lb_protocol         = "http"
        instance_port       = "${var.server_port}"
        instance_protocol   = "http" 
    }

    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        interval            = 30
        target              = "HTTP:${var.server_port}/"
     
    }
}

resource "aws_autoscaling_group" "example" {
    launch_configuration = "${aws_launch_configuration.example.id}"
    availability_zones = ["us-west-2a", "us-west-2b"]

    load_balancers      = ["${aws_elb.example.name}"]
    health_check_type   = "ELB"

    min_size = 2
    max_size = 2

    tag {
        key                 = "Name"
        value               = "terraform-asg-example"
        propagate_at_launch = true  
    }
}

resource "aws_launch_configuration" "example" {
    image_id             = "ami-6f68cf0f"
    instance_type   = "t2.micro"
    security_groups = ["${aws_security_group.instance.id}"]

    user_data = <<-EOF
                #!/bin/bash
                echo "Hellow World" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF

    lifecycle {
        create_before_destroy = true
    }

}

resource "aws_security_group" "instance" {
    name = "${var.cluster_name}-instance"

    ingress {
        from_port   = "${var.server_port}"
        to_port     = "${var.server_port}"
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "elb" {
    name = "${var.cluster_name}-elb"

    ingress {
        from_port   = "${var.server_port}"
        to_port     = "${var.server_port}"
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
