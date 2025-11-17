resource "aws_security_group" "https_only" {
  name = "https-only-sg"
  description = "Security group allowing only HTTPS traffic"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS inbound"
  }
  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS outbound"
  }
  tags = {
    Name = "https-only-sg"
  }
}
