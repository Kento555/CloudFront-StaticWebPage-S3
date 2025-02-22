variable "name_prefix" {
 description = "Name prefix "
 type        = string
 default     = "ws"
}

variable "s3_domain_name" {
 description = "Domain name for S3 Bucket "
 type        = string
 default     = "ws-tf.sctp-sandbox.com"
}


variable "vpc_id" {
 description = "Virtual private cloud id"
 type        = string
 default     = "vpc-0a8963a83c4771c93"  # This is VPC ID for "WS-Feb-vpc"
#  default     = "vpc-012814271f30b4442"    # This is VPC ID for "ce9-coaching-shared-vpc"
}

variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-east-1"  # Replace with your desired default region
}
