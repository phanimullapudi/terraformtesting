variable "server_port" {
    description = "The port the server will use for HTTP request"
    default = 8080
}

resource "aws_instance" "example" {
    ami             = "ami-6f68cf0f"
    instance_type   = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.instance.id}"]

    user_data = <<-EOF
                #!/bin/bash
                echo "Hellow World" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF

        tags = {
        Name = "terraform-example"
    } 

    lifecycle {
        create_before_destroy = true
    }

}

resource "aws_security_group" "instance" {
    name = "terraform-example-instance"

    ingress {
        from_port   = "${var.server_port}"
        to_port     = "${var.server_port}"
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output "public_ip" {
    value = "${aws_instance.example.public_ip}"

}
