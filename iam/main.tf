resource "aws_iam_policy" "main" {
  name        = var.aws_iam_policy_name
  path        = "/"
  description = "Policy for S3 access from EC2"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:ListBucket"]
        Resource = [var.s3_arn]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = join("", [var.s3_arn, "/*"])
      },
    ]
  })
}


resource "aws_iam_role" "main" {

  name = var.aws_iam_role_name

  assume_role_policy = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

}

resource "aws_iam_role_policy_attachment" "main" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.main.arn

}

resource "aws_iam_instance_profile" "main" {
  name = var.aws_iam_instance_profile_name
  role = aws_iam_role.main.name
}