output "vpc_id" {
  description = "ID of the VPC"
  value = aws_vpc.main.id
}

output "internet_gateway_id" {
  description = "ID for IGW"
  value = aws_internet_gateway.igw_infranet.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value = [
    aws_subnet.public_subnet_a.id,
    aws_subnet.public_subnet_b.id
  ]
}

output "private_subnet_ids" {
  description = "ID's of private subnets"
  value = [
    aws_subnet.private_subnet_a.id,
    aws_subnet.private_subnet_b.id
  ]
}