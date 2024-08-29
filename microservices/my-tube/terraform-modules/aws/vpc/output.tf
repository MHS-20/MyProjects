// VPC module outputs

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "Public subnet ids"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "Private subnet ids"
  value       = aws_subnet.private[*].id
}
