resource "aws_cloudfront_distribution" "cloudfront2" {
    origin {
        domain_name = "s3-bucket2-25.s3.amazonaws.com"
       origin_id = "s3-bucket2-25"


        custom_origin_config {
            http_port = 80
            https_port = 80
            origin_protocol_policy = "match-viewer"
            origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
        }
    }
       
    enabled = true


    default_cache_behavior {
        allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods = ["GET", "HEAD"]
        target_origin_id = "s3-bucket2-25"


        forwarded_values {
            query_string = false
        
            cookies {
               forward = "none"
            }
        }
        viewer_protocol_policy = "allow-all"
        min_ttl = 0
        default_ttl = 3600
        max_ttl = 86400
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