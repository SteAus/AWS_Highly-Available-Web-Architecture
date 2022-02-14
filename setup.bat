@ECHO OFF
echo yes | terraform apply -target="aws_internet_gateway.igw"
echo yes | terraform apply -target="aws_acm_certificate.acm-cert"
echo yes | terraform apply
PAUSE