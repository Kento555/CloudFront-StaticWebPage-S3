resource "aws_s3_bucket" "static_site_bucket" {
  bucket = var.s3_domain_name
}

resource "aws_s3_bucket_ownership_controls" "s3_ownership" {
  bucket = aws_s3_bucket.static_site_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket = aws_s3_bucket.static_site_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "AllowCloudFrontServicePrincipal",
      Effect    = "Allow"
      Principal = { "Service": "cloudfront.amazonaws.com" }
      Action    = "s3:GetObject"
      Resource  = "${aws_s3_bucket.static_site_bucket.arn}/*"
      Condition = {
        StringEquals = { "AWS:SourceArn" = aws_cloudfront_distribution.cloudfront.arn }
      }
    }]
  })
}

output "bucket_name" {
  value = aws_s3_bucket.static_site_bucket.bucket
}

# Clone the GitHub repository and upload content to S3
resource "null_resource" "clone_and_upload" {
  provisioner "local-exec" {
    command = <<EOT
      git clone https://github.com/cloudacademy/static-website-example.git /tmp/static-website-example &&
      aws s3 sync /tmp/static-website-example s3://${aws_s3_bucket.static_site_bucket.bucket} --exclude '*.MD' --exclude '.git*' &&
      rm -rf /tmp/static-website-example
    EOT
  }

  # Ensure the S3 bucket is created before running the script
  depends_on = [aws_s3_bucket.static_site_bucket]
}
