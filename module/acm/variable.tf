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