resource "aws_iam_user" "iam_user" {
  name = "demo_name"
  tags = {
    Name = "demo_name"
  }
}

resource "aws_iam_role" "iam_role" {
  name = "iam_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = {
    Name = "iam_role"
  }
}
