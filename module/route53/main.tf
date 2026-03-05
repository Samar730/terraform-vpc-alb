data "aws_route53_zone" "selected" {
  name         = var.zone_name
  private_zone = false
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = var.subdomain_name
  type    = "A"
  allow_overwrite = true

  alias {
    evaluate_target_health = true
    name = var.alb_dns_name
    zone_id = var.alb_zone_id
  }
}
