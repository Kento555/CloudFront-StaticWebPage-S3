
data "aws_route_table" "example" {
  vpc_id = var.vpc_id  # Replace with your VPC ID
  filter {
    name   = "tag:Name"
    values = ["*WS-Feb-rtb-private1-us-east-1a*"]  # Replace with your route table's tag
  }
}

output "route_table_id" {
  value = data.aws_route_table.example.id
}

# # Define the private route table
# resource "aws_route_table" "private" {
#   vpc_id = var.vpc_id

#   tags = {
#     Name = "${var.name_prefix}-private-route-table"
#   }
# }

# # Associate the private route table with the private subnets
# resource "aws_route_table_association" "private" {
#   for_each       = toset(data.aws_subnets.private_subnets.ids)
#   subnet_id      = each.value
#   route_table_id = aws_route_table.private.id
# }