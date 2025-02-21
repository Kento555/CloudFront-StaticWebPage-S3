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


# # Fetch VPC
# variable "vpc_id" {
#  description = "Virtual private cloud id"
#  type        = string
#  default     = "vpc-012814271f30b4442"    # This is VPC ID for "ce9-coaching-shared-vpc"
# #  default     = "vpc-05cd5a94a3a4494ab"  # This is VPC ID for "WS-2025-2201-vpc"
# }


