module "vpc" {
    source = "./module/vpc"
    vpc_cidr_block = var.vpc_cidr_block
    vpc_name = var.vpc_name
    igw_name = var.igw_name
    rnat_gw_name = var.rnat_gw_name
    public_subnet_a_cidr = var.public_subnet_a_cidr
    public_subnet_b_cidr = var.public_subnet_b_cidr
    private_subnet_a_cidr = var.private_subnet_a_cidr
    private_subnet_b_cidr = var.private_subnet_b_cidr
    az_1 = var.az_1
    az_2 = var.az_2
    internet_cidr = var.internet_cidr
    public_rt_name = var.public_rt_name
    private_rt_name = var.private_rt_name
}

module "sg" {
    source = "./module/sg"
    vpc_id = module.vpc.vpc_id
    alb_sg_name = var.alb_sg_name
    ec2_sg_name = var.ec2_sg_name
    bh_sg_name = var.bh_sg_name
    trusted_ip_cidr = var.trusted_ip_cidr
}

module "ec2" {
    source = "./module/ec2"
    instance_type = var.instance_type
    bastion_ec2_name = var.bastion_ec2_name
    public_subnet_ids = module.vpc.public_subnet_ids
    bh_sg_id = module.sg.bh_sg_id
    key_name = var.key_name
    private_subnet_ids = module.vpc.private_subnet_ids
    private_ec2_sg_id = module.sg.ec2_sg_id
    private_ec2_a_name = var.private_ec2_a_name
    private_ec2_b_name = var.private_ec2_b_name
}

module "alb" {
    source = "./module/alb"
    private_ec2_tg_name = var.private_ec2_tg_name
    vpc_id = module.vpc.vpc_id
    private_instance_ids = module.ec2.private_ec2_id
    public_subnet_ids = module.vpc.public_subnet_ids
    alb_sg_id = module.sg.alb_sg_id
    alb_name = var.alb_name
    load_balancer_type = var.load_balancer_type
    acm_arn = module.acm.certificate_arn
}

module "acm" {
    source = "./module/acm"
    subdomain_name = var.subdomain_name
    zone_name = var.zone_name
}

module "Route53" {
    source = "./module/route53"
    zone_name = var.zone_name
    subdomain_name = var.subdomain_name
    alb_dns_name = module.alb.alb_dns_name
    alb_zone_id = module.alb.alb_zone_id
}