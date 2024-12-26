/*
resource "aws_wafv2_web_acl" "cloudfront_waf" {
  name        = "webapp_waf"
  description = "WAF for CloudFront"
  scope       = "CLOUDFRONT"  # CloudFront is a global resource

  default_action {
    allow {}
  }

  rule {
    name     = "BlockSQLInjection"
    priority = 0
    statement {
      sqli_match_statement {
        field_to_match {
          body {}
        }
        text_transformation {
          priority = 0
          type     = "NONE"
        }
      }
    }

    action {
      block {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name               = "BlockSQLInjection"
      sampled_requests_enabled  = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name               = "cloudfront_waf"
    sampled_requests_enabled  = true
  }
}
*/

resource "aws_cloudfront_distribution" "webapp_cf" {
  enabled = true
  
  origin {
    domain_name = aws_lb.app_lb.dns_name
    origin_id   = "ALB"
    
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
  
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "ALB"
    viewer_protocol_policy = "redirect-to-https"
    
    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }
  }
  
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

