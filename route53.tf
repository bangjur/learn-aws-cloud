resource "aws_route53_zone" "primary" {
  name = "www.juriweb.com"  # replace with your domain name
}

resource "aws_route53_record" "alb_record" {
  zone_id = aws_route53_zone.primary.id
  name    = "www.juriweb.com"  # replace with your desired subdomain
  type    = "A"
  alias {
    name                   = aws_lb.app_lb.dns_name  # ALB DNS name
    zone_id                = aws_lb.app_lb.zone_id  # ALB hosted zone ID
    evaluate_target_health = true
  }
}
