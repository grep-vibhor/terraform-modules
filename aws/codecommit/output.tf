output "repository_id" {
  value = aws_codecommit_repository.ven_repo.repository_id
}
output "arn" {
  value = aws_codecommit_repository.ven_repo.arn
}
output "clone_url_http" {
  value = aws_codecommit_repository.ven_repo.clone_url_http
}
output "clone_url_ssh" {
  value = aws_codecommit_repository.ven_repo.clone_url_ssh
}
