output "bh_ec2_id" {
    description = "The ID of the Bastion EC2 instance"
    value = aws_instance.bastion_ec2.id
}

output "bastion_public_ip" {
  description = "Public IP of Bastion"
  value       = aws_instance.bastion_ec2.public_ip
}

output "private_ec2_id" {
    description = "ID's of Private EC2 Instances"
    value = [
        aws_instance.private_ec2_a.id,
        aws_instance.private_ec2_b.id
    ]
}

