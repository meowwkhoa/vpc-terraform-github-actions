output "public_instance_id" {
  description = "The ID of the public EC2 instance"
  value       = aws_instance.public.id
}

output "private_instance_id" {
  description = "The ID of the private EC2 instance"
  value       = aws_instance.private.id
}

output "public_instance_public_ip" {
  description = "The public IP address of the public EC2 instance"
  value       = aws_instance.public.public_ip
}

output "private_instance_private_ip" {
  description = "The private IP address of the private EC2 instance"
  value       = aws_instance.private.private_ip
}