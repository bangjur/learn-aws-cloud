
resource "aws_route53_zone" "primary" {
  name = "www.juriweb.com"  # replace with your domain name
}

resource "aws_route53_record" "cloudfront_record" {
  zone_id = aws_route53_zone.primary.id
  name    = "www.juriweb.com"  # replace with your desired subdomain
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.webapp_cf.domain_name
    zone_id                = aws_cloudfront_distribution.webapp_cf.hosted_zone_id
    evaluate_target_health = true
  }
}
