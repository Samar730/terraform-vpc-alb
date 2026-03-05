variable "private_ec2_tg_name" {
    type = string
    description = "Name of Target Group"
}

variable "vpc_id" {
    type = string
    description = "Attach Target Group to a VPC"
}

variable "private_instance_ids" {
    type = list(string)
}

variable "alb_name" {
    type = string
    description = "Name of the ALB"
}

variable "load_balancer_type" {
    type = string
    description = "Describing whether the ALB is internal facing or Public"
}

variable "alb_sg_id" {
    type = string
    description = "Attaching ALB to ALB-SG"
}

variable "public_subnet_ids" {
    type = list(string)
    description = "Attaching ALB in Public Subnets"
}

variable "acm_arn" {
    type = string
    description = "ACM certificate assigned for HTTPS"
    default = null
}