data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Creation of Bastion EC2 instance
resource "aws_instance" "bastion_ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id = var.public_subnet_ids[0] # Using Public subnet A in this case so first Public subnet
  vpc_security_group_ids = [ var.bh_sg_id ]
  key_name = var.key_name


  tags = {
    Name = var.bastion_ec2_name
  }
}

# Creation of Private EC2 instance (1/2) -> Private subnet A
resource "aws_instance" "private_ec2_a" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id = var.private_subnet_ids[0]
  vpc_security_group_ids = [ var.private_ec2_sg_id ]
  key_name = var.key_name
  associate_public_ip_address = false

  user_data = file("${path.module}/user_data_nginx.sh")


  tags = {
    Name = var.private_ec2_a_name
  }
}

# Creation of Private EC2 Instance (2/2) -? Private Subnet B
resource "aws_instance" "private_ec2_b" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id = var.private_subnet_ids[1]
  vpc_security_group_ids = [ var.private_ec2_sg_id ]
  key_name = var.key_name
  associate_public_ip_address = false
  
  user_data = file("${path.module}/user_data_nginx.sh")

  tags = {
    Name = var.private_ec2_b_name
  }
}