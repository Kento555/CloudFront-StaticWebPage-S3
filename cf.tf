resource "aws_cloudfront_distribution" "cloudfront" {
    depends_on = [aws_acm_certificate_validation.cert_validation]
    
  origin {
    domain_name              = aws_s3_bucket.static_site_bucket.bucket_regional_domain_name
    origin_id                = aws_s3_bucket.static_site_bucket.id
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = [var.s3_domain_name]

  web_acl_id = aws_wafv2_web_acl.waf_acl.arn

  default_cache_behavior {
    target_origin_id       = aws_s3_bucket.static_site_bucket.id
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    cache_policy_id  = "658327ea-f89d-4fab-a63d-7e88639e58f6" # AWS Managed CachingOptimized
    compress = true

  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Description = "CGPT TF CFS3"
  }

}

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "${var.s3_domain_name}-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}