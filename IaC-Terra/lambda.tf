# role for allowing lambda

resource "aws_iam_role" "lambda_iam" {
  name = "lambda_iam"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
# Policy For Lambda IAM Role (to allow these lambda functions to 
# s3 and ses )
resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = aws_iam_role.lambda_iam.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*",
        "ses:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

# Creating Lambda resource
resource "aws_lambda_function" "lambda_fun" {
  function_name    = "lambda_fun"
  role             = aws_iam_role.lambda_iam.arn
  handler          = "script/lambda_function.lambda_handler"
  filename         = "../script.zip"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256("../script.zip")
  environment {
    variables = {
      SENDER_EMAIL   = var.sender_email
      RECEIVER_EMAIL = var.receiver_email
    }
  }
}
