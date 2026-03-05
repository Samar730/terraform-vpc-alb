variable "instance_type" {
    type = string
    description = "The size of the EC2 instance"
}

variable "bastion_ec2_name" {
    type = string
    description = "Name of the Bastion EC2 instance"
}

variable "public_subnet_ids" {
    type = list(string)
    description = "Placing Bastion Host EC2 in Public Subnet A"
}

variable "bh_sg_id" {
    type = string
    description = "Attach Bastion Security Group with Bastion EC2"
}

variable "key_name" {
    type = string
    description = "Key pair name in AWS"
}

variable "private_subnet_ids" {
    type = list(string)
    description = "Placing Private ec2-A in Private Subnet A"
}

variable "private_ec2_sg_id" {
    type = string
    description = "Attach Private EC2 Security Group with Private EC2-A"
}

variable "private_ec2_a_name" {
    type = string
    description = "Name of Private EC2-A Instance"
}

variable "private_ec2_b_name" {
    type = string
    description = "Name of Private EC2-B Instance"
}