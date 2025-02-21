resource "aws_acm_certificate" "cert" {
  provider          = aws.us_east
  domain_name       = var.s3_domain_name
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

# Wait for the ACM certificate to be validated
resource "aws_acm_certificate_validation" "cert_validation" {
  provider                = aws.us_east
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}