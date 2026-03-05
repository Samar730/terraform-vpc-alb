variable "aws_region" {
    type = string
    description = "Region to deploy resources"
    default = "eu-west-2"
}

variable "vpc_cidr_block" {
    type = string
    description = "CIDR block for the main VPC"
    default = "10.0.0.0/16"
}

variable "vpc_name" {
    type = string
    description = "Name/Title of VPC"
    default = "infranet"
}

variable "igw_name" {
  type = string
  description = "Name of Internet Gateway"
  default = "igw-infranet"
}

variable "rnat_gw_name" {
  type = string
  description = "Name of Regional NAT Gateway"
  default = "rnat-gw-infranet"
}

variable "public_subnet_a_cidr" {
  type = string
  default = "10.0.1.0/24"
}

variable "public_subnet_b_cidr" {
  type = string
  default = "10.0.2.0/24"
}

variable "private_subnet_a_cidr" {
  type = string
  default = "10.0.3.0/24"
}

variable "private_subnet_b_cidr" {
  type = string
  default = "10.0.4.0/24"
}

variable "az_1" {
  type = string
  default = "eu-west-2a"
}

variable "az_2" {
  type = string
  default = "eu-west-2b"
}

variable "internet_cidr" {
  type = string
  description = "CIDR block for internet"
  default = "0.0.0.0/0"
}

variable "public_rt_name" {
  type = string
  description = "Name of Public Route Table"
  default = "Public-RT"
}

variable "private_rt_name" {
  type = string
  description = "Name of Private Route Table"
  default = "Private-RT"
}

######## variable.tf /sg
variable "alb_sg_name" {
    type = string
    description = "Name of ALB Security Group"
    default = "alb-sg"
}

variable "ec2_sg_name" {
    type = string
    description = "Name of the EC2 Security Group"
    default = "ec2-sg"
}

variable "bh_sg_name" {
    type = string
    description = "Name of Bastion Host Security Group"
    default = "Bastion-Host-sg"
}

variable "trusted_ip_cidr" {
    type = string
    description = "Value of Public IP address for bastion cidr_ipv4"
    default = "95.147.31.36/32"
}

################ variable.tf /ec2 
variable "instance_type" {
    type = string
    description = "The size of the EC2 instance"
    default = "t3.micro"
}

variable "bastion_ec2_name" {
    type = string
    description = "Name of the Bastion EC2 instance"
    default = "Bastion_ec2"
}

variable "key_name" {
    type = string
    description = "Key pair name in AWS"
    default = "ubuntu-1"
}

variable "private_ec2_a_name" {
    type = string
    description = "Name of Private EC2-A Instance"
    default = "Private-ec2-a"
}

variable "private_ec2_b_name" {
    type = string
    description = "Name of Private EC2-B Instance"
    default = "private_ec2_b"
}

######### variable.tf for alb module 
variable "private_ec2_tg_name" {
    type = string
    description = "Name of Target Group"
    default = "Private-nginx-tg"
}

variable "alb_name" {
    type = string
    description = "Name of the ALB"
    default = "ALB"
}

variable "load_balancer_type" {
    type = string
    description = "Describing whether the ALB is internal facing or Public"
    default = "application"
}

######## ACM variable.tf file 
variable "subdomain_name" {
    type = string
    description = "Name of the subdomain"
    default = "app.cloudbysamar.com"
}

variable "zone_name" {
    type = string
    description = "Root domain name in AWS"
    default = "cloudbysamar.com"
}

