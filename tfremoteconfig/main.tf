provider "aws" {
    region = "us-west-2"
}

resource "aws_s3_bucket" "terraform_state" {
    bucket  = "pk-terraform-up-and-running"

    versioning {
        enabled = true
    }

    lifecycle {
        prevent_destroy = true
    }
}