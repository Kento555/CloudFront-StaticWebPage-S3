data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id] 
  }
  filter {
    name   = "tag:Name"
    values = ["*private*"] # This will match any subnet with "private" in its Name tag.
  }
}