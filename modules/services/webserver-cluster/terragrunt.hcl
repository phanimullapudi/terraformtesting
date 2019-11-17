# terragrunt.hcl example
remote_state {
  backend = "s3"
  config = {
    bucket         = "phani-my-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "phani-tf-lock-table"
  }   
}