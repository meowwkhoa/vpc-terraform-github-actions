variable "region" {
  description = "AWS Region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "az" {
  description = "Availability Zone"
  type        = string
  default     = "us-east-1a"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the Public Subnet"
  type        = string
  default     = "10.0.1.0/24"
}


variable "private_subnet_cidr" {
  description = "CIDR block for the Private Subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "ami" {
  description = "AMI ID for the EC2 instances"
  type        = string
  default     = "ami-08c40ec9ead489470"
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "allowed_ip" {
  description = "IP address allowed to SSH into Public EC2 instance"
  type        = string
  default     = "192.168.1.1/32"
}
