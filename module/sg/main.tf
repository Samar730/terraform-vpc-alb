# ALB-SG Creation
resource "aws_security_group" "sg_alb" {
    vpc_id = var.vpc_id
    description = "Security group for ALB allowing inbound HTTP/HTTPS from the internet"

    tags = {
      Name = var.alb_sg_name
    }
}

# Inbound/Outbound rules for ALB-SG HTTP + HTTPS 
resource "aws_vpc_security_group_ingress_rule" "alb_sg_ingress_http" {
        security_group_id = aws_security_group.sg_alb.id
        description = "Allow HTTP (80) traffic from the internet"
        cidr_ipv4   = "0.0.0.0/0"
        from_port   = 80
        ip_protocol = "tcp"
        to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "alb_sg_https" {
        security_group_id = aws_security_group.sg_alb.id
        description = "Allow HTTPS (443) traffic from the internet"
        cidr_ipv4   = "0.0.0.0/0"
        from_port   = 443
        ip_protocol = "tcp"
        to_port     = 443
}

resource "aws_vpc_security_group_egress_rule" "alb_sg_egress" {
        security_group_id = aws_security_group.sg_alb.id
        description = "Allow All Outbound traffic to the Internet"
        cidr_ipv4 = "0.0.0.0/0"
        ip_protocol = "-1"
}

# Bastion Host Security Group Creation
resource "aws_security_group" "bh_sg" {
    vpc_id = var.vpc_id
    description = "Security Group for Bastion host"

    tags = {
      "Name" = var.bh_sg_name
    }
}

resource "aws_vpc_security_group_ingress_rule" "bh_sg_ssh" {
    security_group_id = aws_security_group.bh_sg.id
    description = "Allow inbound SSH (22) only from a trusted IP Address"
    cidr_ipv4 = var.trusted_ip_cidr
    from_port = 22
    ip_protocol = "tcp"
    to_port = 22
}

resource "aws_vpc_security_group_egress_rule" "bh_sg_egress" {
    security_group_id = aws_security_group.bh_sg.id
    description = "Allow Outbound from the Internet"
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
}

# Private EC2-SG Creation 
resource "aws_security_group" "ec2_sg" {
    vpc_id = var.vpc_id
    description = "Security Group for 2 Private EC2 Instances"

    tags = {
      "Name" = var.ec2_sg_name
    }
}

resource "aws_vpc_security_group_ingress_rule" "ec2_sg_http" {
    security_group_id = aws_security_group.ec2_sg.id
    description = "Allow Inbound HTTP (80) traffic from ALB Security Group"
    
    from_port = 80
    ip_protocol = "tcp"
    to_port = 80
    # Source is the ALB Security Group not a CIDR 
    referenced_security_group_id = aws_security_group.sg_alb.id
}

resource "aws_vpc_security_group_ingress_rule" "ec2_sg_ssh" {
    security_group_id = aws_security_group.ec2_sg.id
    description = "Allow inbound SSH (22) traffic from Bastion Host Security Group Only"

    from_port = 22
    ip_protocol = "tcp"
    to_port = 22
    # Source is the Bastion Host Securitiy Group not a CIDR
    referenced_security_group_id = aws_security_group.bh_sg.id    
}

resource "aws_vpc_security_group_egress_rule" "ec2_sg_egress" {
    security_group_id = aws_security_group.ec2_sg.id
    description = "Allow Outbound form the Internet via Regional NAT Gateway/Other routes"
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
}