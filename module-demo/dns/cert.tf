#-------------------------------------------------------------------------------------------------------------------
#Public Subdomain Zone
#For use in subdomains, note that you need to create a aws_route53_record of type NS as well as the subdomain zone.
#-------------------------------------------------------------------------------------------------------------------
resource "aws_route53_zone" "zone" {
  name = "ecs.inecsoft.cub"
  tags = {
    Environment = "zone"
  }
}

#-------------------------------------------------------------------------------------------------------------------
data "aws_route53_zone" "zone_selected" {
  name         = "ecs.inecsoft.cub."
  private_zone = false
}
#-------------------------------------------------------------------------------------------------------------------
resource "aws_route53_record" "cert_validation" {
  name    = aws_acm_certificate.certificate.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.certificate.domain_validation_options.0.resource_record_type
  zone_id = data.aws_route53_zone.zone_selected.id
  #zone_id = "${aws_route53_zone.zone.id}"
  records = ["${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}
#-------------------------------------------------------------------------------------------------------------------
resource "aws_acm_certificate" "certificate" {
  domain_name       = "*.ecs.inecsoft.cub"
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }
  lifecycle {
    create_before_destroy = true
  }
}
#-------------------------------------------------------------------------------------------------------------------
resource "aws_acm_certificate_validation" "certificate" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}"]
}
#-------------------------------------------------------------------------------------------------------------------

