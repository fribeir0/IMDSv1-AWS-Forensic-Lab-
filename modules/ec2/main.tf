# EC2 1
resource "aws_instance" "ec2_1" {
  ami           = "ami-0ec10929233384c7f"
  instance_type = "t2.micro"
  subnet_id     = var.subnet_private1
  vpc_security_group_ids = [aws_security_group.deny_all.id]
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
  metadata_options {
    http_endpoint = "disabled"
  }

  root_block_device {
    encrypted = false
  }
  tags = {
    Name = "ec2-forensic"
  }
}

# EC2 2
resource "aws_instance" "ec2_2" {
  ami           = "ami-0ec10929233384c7f"
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet
  vpc_security_group_ids = [aws_security_group.deny_all.id]
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
  associate_public_ip_address = false

  metadata_options {
    http_endpoint = "disabled"
  }

  root_block_device {
    encrypted = false
  }
  tags = {
    Name = "ec2-vulnerable"
  }
}
