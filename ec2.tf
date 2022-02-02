provider "aws"{
    region = "us-east-1"
    access_key = "AKIAYJZIJVLFES7VXNUA"
    secret_key = "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"
}
resource "aws_instance" "test-server"{
    ami = "ami-0a8b4cd432b1c3063"
    instance_type = "t2.micro"
}