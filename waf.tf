resource "aws_wafv2_web_acl" "waf_acl" {
  name        = "${var.name_prefix}-waf"
  scope       = "CLOUDFRONT"
  description = "WAF for ${var.name_prefix}"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.name_prefix}-waf"
    sampled_requests_enabled   = true
  }
 }