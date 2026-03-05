variable "vpc_id" {
    type = string
}

variable "alb_sg_name" {
    type = string
    description = "Name of ALB Security Group"
}

variable "ec2_sg_name" {
    type = string
    description = "Name of the EC2 Security Group"
}

variable "bh_sg_name" {
    type = string
    description = "Name of Bastion Host Security Group"
}

variable "trusted_ip_cidr" {
    type = string
    description = "Value of Public IP address for bastion cidr_ipv4"
}