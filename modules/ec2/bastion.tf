resource "aws_instance" "vuln02" {
  ami           = "ami-0ec10929233384c7f"
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet
  iam_instance_profile = aws_iam_instance_profile.vulne_profile.name
  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.bastion_sg.id
  ]

  key_name = aws_key_pair.bastion_key.key_name

  tags = {
    Name = "vuln02-ec2"
  }
}

resource "tls_private_key" "bastion_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bastion_key" {
  key_name   = "bastion-key"
  public_key = tls_private_key.bastion_key.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.bastion_key.private_key_pem
  filename = "${path.module}/bastion.pem"
  file_permission = "0400"
}


