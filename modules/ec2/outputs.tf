output "instances" {
  value = [
    aws_instance.ec2_1.id,
    aws_instance.ec2_2.id
  ]
}