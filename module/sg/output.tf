output "alb_sg_id" {
    description = "The ID of the ALB Security Group"
    value = aws_security_group.sg_alb.id
}

output "bh_sg_id" {
    description = "The ID of Bastion Host Security Group"
    value = aws_security_group.bh_sg.id
}

output "ec2_sg_id" {
    description = "ID of EC2 Security Group"
    value = aws_security_group.ec2_sg.id
}