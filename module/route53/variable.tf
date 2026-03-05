variable "zone_name" {
    type = string
    description = "Domain name in AWS"
    default = "cloudbysamar.com"
}

variable "subdomain_name" {
    type = string
    description = "Subdomain name in AWS"
    default = "app.cloudbysamar.com"
}

variable "alb_dns_name" {
    type = string
    description = "DNS name of the ALB for Route53 Alias record"
}

variable "alb_zone_id" {
    type = string
    description = "Hosted zone ID of the ALB for Route53 Alias record"
}