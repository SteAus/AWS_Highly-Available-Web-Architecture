variable "access_key" {
  type    = string
  default = ""
}
variable "secret_key" {
  type    = string
  default = ""
}
variable "domain" {
  type    = string
  default = ""
}
provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}
terraform {
  backend "s3" {
    bucket = "ste-aus-dev"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
