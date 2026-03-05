variable "vpc_cidr_block" {
    type = string
    description = "CIDR block for the main VPC"
}

variable "vpc_name" {
    type = string
    description = "Name/Title of VPC"
}

variable "igw_name" {
  type = string
  description = "Name of Internet Gateway"
}

variable "rnat_gw_name" {
  type = string
  description = "Name of Regional NAT Gateway"
}

variable "public_subnet_a_cidr" {
  type = string
}

variable "public_subnet_b_cidr" {
  type = string
}

variable "private_subnet_a_cidr" {
  type = string
}

variable "private_subnet_b_cidr" {
  type = string
}

variable "az_1" {
  type = string
}

variable "az_2" {
  type = string
}

variable "internet_cidr" {
  type = string
  description = "CIDR block for internet"
}

variable "public_rt_name" {
  type = string
  description = "Name of Public Route Table"
}

variable "private_rt_name" {
  type = string
  description = "Name of Private Route Table"
}