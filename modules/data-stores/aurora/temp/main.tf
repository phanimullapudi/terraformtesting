variable "secrethub_passphrase" {}

provider "secrethub" {
  credential            = "${file("~/.secrethub/credential")}"
  credential_passphrase = "${var.secrethub_passphrase}"
}