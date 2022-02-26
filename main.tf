variable "access_key" {
  type = string
  default = ""
}
variable "secret_key" {
  type = string
  default = ""
}
provider "aws" {
  region     = "us-east-1"
  access_key = var.key
  secret_key = var.secret
}
