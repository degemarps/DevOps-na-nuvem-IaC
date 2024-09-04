output "vpc_arn" {
  value = aws_vpc.this.arn
}

output "public_subnets_arns" {
  value = aws_subnet.publics[*].arn
}

output "private_subnets_arns" {
  value = aws_subnet.privates[*].arn
}

output "vpc_internet_gateway_arn" {
  value = aws_internet_gateway.this.arn
}

output "vpc_nat_gateway_arn" {
  value = aws_nat_gateway.this.id
}

output "eip_arn" {
  value = aws_eip.this.arn
}