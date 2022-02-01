provider "aws"{
    region = "us-east-1"
    access_key = "AKIAYJZIJVLFES7VXNUA"
    secret_key = "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"
}
resource "aws_instance" "test-server"{
    ami = "ami-0b6705f88b1f688c1"
    instance_type = "t2.micro"
}