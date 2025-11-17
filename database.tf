resource "aws_db_subnet_group" "main" {
  name = "nextjs-db-subnet-group"
  subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]
  tags = {
    Name = "nextjs-db-subnet-group"
    Environment = "production"
  }
}

resource "aws_db_instance" "main" {
  identifier = "nextjs-production-db"
  allocated_storage = 20
  max_allocated_storage = 100
  storage_type = "gp2"
  engine = "postgres"
  engine_version = "14.9"
  instance_class = "db.t3.micro"
  db_name = "nextjsapp"
  username = "postgres"
  manage_master_user_password = true
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name = aws_db_subnet_group.main.name
  backup_retention_period = 7
  backup_window = "03:00-04:00"
  maintenance_window = "sun:04:00-sun:05:00"
  skip_final_snapshot = false
  final_snapshot_identifier = "nextjs-production-db-final-snapshot"
  tags = {
    Name = "nextjs-production-db"
    Environment = "production"
  }
}

resource "aws_dynamodb_table" "sessions" {
  name = "nextjs-sessions"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "sessionId"
  attribute = [{
      name = "sessionId"
      type = "S"
    }]
  ttl = {
    attribute_name = "expires"
    enabled = true
  }
  tags = {
    Name = "nextjs-sessions"
    Environment = "production"
  }
}
