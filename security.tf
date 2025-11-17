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

resource "aws_security_group" "alb" {
  name = "nextjs-alb-sg"
  description = "Security group for ALB"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "nextjs-alb-sg"
    Environment = "production"
  }
}

resource "aws_security_group" "ecs" {
  name = "nextjs-ecs-sg"
  description = "Security group for ECS tasks"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    security_groups = [aws_security_group.alb.id]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "nextjs-ecs-sg"
    Environment = "production"
  }
}

resource "aws_security_group" "rds" {
  name = "nextjs-rds-sg"
  description = "Security group for RDS database"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    security_groups = [aws_security_group.ecs.id]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "nextjs-rds-sg"
    Environment = "production"
  }
}
