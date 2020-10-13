#------------------------------------------------------------------------------------------
# data "aws_route53_zone" "zone" {
#   name         = "inecsoft.co.uk"
#   private_zone = true
# }
#invalid value for domain (cannot end with a period)
resource "aws_route53_zone" "cloud-zone" {
  name = var.domain
}
#------------------------------------------------------------------------------------------
# Example SES Domain Identity
#terraform import aws_ses_domain_identity.ses-domain-identity cloud.inecsoft.co.uk
#------------------------------------------------------------------------------------------
resource "aws_ses_domain_identity" "ses-domain-identity" {
   domain = var.domain
  #domain = cloud.inecsoft.co.uk
}

output "ses-domain-identity-verification-token" {
  description = "A code which when added to the domain as a TXT record will signal to SES that the owner of the domain has authorised SES to act on their behalf. The domain identity will be in state \"verification pending\" until this is done."
  value       = aws_ses_domain_identity.ses-domain-identity.verification_token
}
#------------------------------------------------------------------------------------------
#terraform import aws_ses_domain_dkim.domain-dkim cloud.inecsoft.co.uk
#------------------------------------------------------------------------------------------
resource "aws_ses_domain_dkim" "domain-dkim" {
  domain = aws_ses_domain_identity.ses-domain-identity.domain
}

output "output" {
  description = "DKIM tokens generated by SES. These tokens should be used to create CNAME records used to verify SES Easy DKIM"
  value       = aws_ses_domain_dkim.domain-dkim.dkim_tokens 
}

#------------------------------------------------------------------------------------------
#on the records part add the . at the end for safety measures
##------------------------------------------------------------------------------------------
resource "aws_route53_record" "ses_amazonses_dkim_record" {
  count   = 3
  zone_id = aws_route53_zone.cloud-zone.zone_id
  name    = "${element(aws_ses_domain_dkim.domain-dkim.dkim_tokens, count.index)}._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = "1800"
  records = ["${element(aws_ses_domain_dkim.domain-dkim.dkim_tokens, count.index)}.dkim.amazonses.com"]
}
#------------------------------------------------------------------------------------------
# Example Route53 MX record
#------------------------------------------------------------------------------------------
resource "aws_route53_record" "example_ses_domain_mail_from_mx" {
  zone_id = aws_route53_zone.cloud-zone.id
  name    = aws_ses_domain_mail_from.example.mail_from_domain
  type    = "MX"
  ttl     = "1800"
  records = [ "10 inbound-smtp.${var.AWS_REGION}.amazonaws.com" ] # Change to the region in which `aws_ses_domain_identity.example` is created
}
#------------------------------------------------------------------------------------------
# Example Route53 TXT record for SPF
#------------------------------------------------------------------------------------------
resource "aws_route53_record" "example_ses_domain_mail_from_txt" {
  zone_id = aws_route53_zone.example.id
  name    = "_amazonses.${var.domain}"
  type    = "TXT"
  ttl     = "1800"
  records = [aws_ses_domain_identity.ses-domain-identity.verification_token]
}
#------------------------------------------------------------------------------------------
<<<<<<< HEAD
# terraform import aws_ses_email_identity.example email@example.com
#check your email 
#------------------------------------------------------------------------------------------
resource "aws_ses_email_identity" "ses-email-identity" {
  email = "ivanpedrouk@gmail.com"
}
#------------------------------------------------------------------------------------------
resource "aws_ses_identity_notification_topic" "identity-notification-topic" {
  topic_arn                = aws_sns_topic.sns-topic.arn
  notification_type        = "Bounce"
  identity                 = aws_ses_domain_identity.ses-domain-identity.domain 
  include_original_headers = true
}
#------------------------------------------------------------------------------------------
# data "aws_iam_policy_document" "policy-doc" {
#   statement {
#     actions   = ["SES:SendEmail", "SES:SendRawEmail"]
#     resources = [aws_ses_domain_identity.ses-domain-identity.arn]

#     principals {
#       identifiers = ["*"]
#       type        = "AWS"
#     }
#   }
# }
# #------------------------------------------------------------------------------------------
# resource "aws_ses_identity_policy" "ses-identity-policy" {
#   identity = aws_ses_domain_identity.ses-domain-identity.arn
#   name     = "user-${random_uuid.uuid.result}"
#   policy   = data.aws_iam_policy_document.policy-doc.json
# }
#------------------------------------------------------------------------------------------
output "uuid" {
  description = "generator of uuid"
  value       = random_uuid.uuid.result
}
#------------------------------------------------------------------------------------------
output "interger" {
  description = "generator of interger"
  value       = random_integer.interger.result
}
#------------------------------------------------------------------------------------------
=======
>>>>>>> parent of 1a04887... project needs tunning to be completed issues in SG config maybe
