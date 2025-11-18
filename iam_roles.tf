# -----------------------------------------------------------------------------
# IAM ROLE FOR LAMBDA FUNCTIONS
# -----------------------------------------------------------------------------
resource "aws_iam_role" "lambda_execution_role" {
  name = "Lambda-Execution-Role"

  # Trust policy allowing Lambda to assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "Lambda-Execution-Role"
  }
}

# Policy granting Lambda necessary permissions for containment actions
resource "aws_iam_policy" "lambda_permissions_policy" {
  name        = "Lambda-Containment-Permissions"
  description = "Allows Lambda to manage EC2, create snapshots, and publish to SNS."

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ec2:DescribeInstances",
          "ec2:ModifyInstanceAttribute", # For changing SGs
          "ec2:CreateSnapshot",          # For taking snapshots
          "ec2:CreateTags"               # For tagging instances
        ],
        Effect   = "Allow",
        Resource = "*" # For simplicity in Sprint 2; can be scoped down later
      },
      {
        Action   = "sns:Publish", # For sending notifications
        Effect   = "Allow",
        Resource = "*" # Should be scoped to the specific SNS topic ARN
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

# Attach the policy to the Lambda role
resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_permissions_policy.arn
}

# -----------------------------------------------------------------------------
# IAM ROLE FOR STEP FUNCTIONS
# -----------------------------------------------------------------------------
resource "aws_iam_role" "step_functions_execution_role" {
  name = "Step-Functions-Execution-Role"

  # Trust policy allowing Step Functions to assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "states.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "Step-Functions-Execution-Role"
  }
}

# Policy granting Step Functions permission to invoke Lambda
resource "aws_iam_policy" "step_functions_permissions_policy" {
  name        = "Step-Functions-Lambda-Invoke-Permissions"
  description = "Allows Step Functions to invoke Lambda functions."

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "lambda:InvokeFunction",
        Effect   = "Allow",
        Resource = "*" # Can be scoped down to specific Lambda ARNs
      }
    ]
  })
}

# Attach the policy to the Step Functions role
resource "aws_iam_role_policy_attachment" "sfn_policy_attach" {
  role       = aws_iam_role.step_functions_execution_role.name
  policy_arn = aws_iam_policy.step_functions_permissions_policy.arn
}
