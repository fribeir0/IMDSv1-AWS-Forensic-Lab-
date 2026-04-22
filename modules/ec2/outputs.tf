output "instances" {
  value = [
    aws_instance.vulne01.id,
    aws_instance.vuln02.id
  ]
}