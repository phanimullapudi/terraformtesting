provider "aws" {
    region = "us-west-2"
}

terraform {
  backend "s3" {}
}

resource "aws_db_instance" "example" {
    engine              = "mysql"
    allocated_storage   = 10
    instance_class      = "db.t3.micro"
    name                = "terraform_example"
    username            = "admin"
    password            = "${var.db_password}"
}