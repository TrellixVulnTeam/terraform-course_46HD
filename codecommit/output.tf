#-----------------------------------------------------------------------------
output "url-http" {
  value = aws_codecommit_repository.app-node-prod.clone_url_http
}
#-----------------------------------------------------------------------------
output "url-ssh" {
  value = aws_codecommit_repository.app-node-prod.clone_url_ssh
}
#-----------------------------------------------------------------------------
