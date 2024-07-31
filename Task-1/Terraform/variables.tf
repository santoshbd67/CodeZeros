variable "region" {
  description = "The AWS region to create resources in"
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
}

variable "instance_type" {
  description = "The type of instance to use"
}

variable "key_pair_name" {
  description = "The name of the key pair to use for SSH access"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
}

variable "availability_zone" {
  description = "The availability zone to use for the subnet"
}
