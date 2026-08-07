resource "tls_private_key" "this_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this_key" {
  key_name   = var.KEY_NAME
  public_key = tls_private_key.this_ssh_key.public_key_openssh
}

resource "local_file" "private_key" {
  filename        = "/mnt/c/Users/PAYAL KHARAT/Downloads/${var.KEY_NAME}.pem"
  content         = tls_private_key.this_ssh_key.private_key_pem
  file_permission = "0400"
}
