output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "The ID of the Public Subnet"
  value       = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  description = "The ID of the Private Subnet"
  value       = module.vpc.private_subnet_id
}

output "public_instance_id" {
  description = "The ID of the Public EC2 instance"
  value       = module.ec2.public_instance_id
}

output "private_instance_id" {
  description = "The ID of the Private EC2 instance"
  value       = module.ec2.private_instance_id
}

output "public_security_group_id" {
  description = "The ID of the Public Security Group"
  value       = module.security_groups.public_security_group_id
}

output "private_security_group_id" {
  description = "The ID of the Private Security Group"
  value       = module.security_groups.private_security_group_id
}
