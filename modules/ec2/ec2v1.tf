resource "aws_instance" "vulne01" {
  ami           = "ami-0ec10929233384c7f"
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet

  associate_public_ip_address = false

  vpc_security_group_ids = [
    aws_security_group.proxy_sg.id
  ]

  key_name = aws_key_pair.vulne_key.key_name

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  user_data = <<EOF
#!/bin/bash
apt-get update -y
apt-get install -y nginx
systemctl start nginx
systemctl enable nginx
EOF

  root_block_device {
    encrypted = false
  }

  tags = {
    Name = "vuln01-proxy"
  }
}

resource "tls_private_key" "vulne_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "vulne_key" {
  key_name   = "vulne-key"
  public_key = tls_private_key.vulne_key.public_key_openssh
}