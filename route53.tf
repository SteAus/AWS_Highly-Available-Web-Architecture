resource "aws_acm_certificate" "acm-cert" {
  domain_name       = aws_route53_record.www.fqdn
  validation_method = "DNS"

}
resource "aws_route53_record" "acm-dns-validation" {
  #Domain validation options can have more than 1 object. E.g if SANs are defined.
  #TODO: Test with SANs.
  for_each = {
    for dvo in aws_acm_certificate.acm-cert.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
      zone_id = dvo.domain_name == var.domain ? data.aws_route53_zone.primary.zone_id : data.aws_route53_zone.primary.zone_id
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = each.value.zone_id
}

data "aws_route53_zone" "primary" {
  name = var.domain
}
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "steausinfra.com"
  type    = "A"

  alias {
    name                   = aws_elb.elb.dns_name
    zone_id                = aws_elb.elb.zone_id
    evaluate_target_health = true
  }
}
