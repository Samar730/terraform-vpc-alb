output "certificate_arn" {
    description = "ARN of the validated ACM certificate for use with HTTPS listener"
    value = aws_acm_certificate_validation.acm_validation.certificate_arn 
}