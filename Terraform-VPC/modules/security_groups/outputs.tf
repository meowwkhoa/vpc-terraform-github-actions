output "public_security_group_id" {
  description = "The ID of the public EC2 security group"
  value       = aws_security_group.public_sg.id
}

output "private_security_group_id" {
  description = "The ID of the private EC2 security group"
  value       = aws_security_group.private_sg.id
}
