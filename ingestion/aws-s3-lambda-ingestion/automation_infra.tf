# SNS Topic for notifications
resource "aws_sns_topic" "soc_alerts_topic" {
  name = "SOC-High-Severity-Alerts"
}


data "archive_file" "lambda_placeholder_zip" {
  type        = "zip"
  source_file = "${path.module}/placeholder_lambda.py" # You'll need to create this file
  output_path = "${path.module}/lambda_function.zip"
}

resource "aws_lambda_function" "isolate_instance_lambda" {
  filename      = data.archive_file.lambda_placeholder_zip.output_path
  function_name = "isolate_instance"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "placeholder_lambda.lambda_handler"
  runtime       = "python3.9"
  source_code_hash = data.archive_file.lambda_placeholder_zip.output_base64sha256
}


# Step Functions State Machine
resource "aws_sfn_state_machine" "ec2_containment_sm" {
  name     = "Automated-EC2-Containment"
  role_arn = aws_iam_role.step_functions_execution_role.arn

  # Simple "Pass" state definition for Sprint 2
  definition = <<EOF
{
  "Comment": "A placeholder state machine for Sprint 2.",
  "StartAt": "Placeholder",
  "States": {
    "Placeholder": {
      "Type": "Pass",
      "Result": "Workflow Initiated.",
      "End": true
    }
  }
}
EOF

  tags = {
    Name = "Automated-EC2-Containment"
  }
}

# EventBridge Rule to detect high-severity GuardDuty findings
resource "aws_cloudwatch_event_rule" "guardduty_high_severity_rule" {
  name        = "GuardDuty-Critical-Finding-Trigger"
  description = "Triggers on GuardDuty findings with severity >= 7.0"

  event_pattern = jsonencode({
  source      = ["aws.guardduty"],
  detail-type = ["GuardDuty Finding"],
  detail = {
    severity = [{
      "numeric" : [">=", 7] // This is the correct syntax for "greater than or equal to"
    }]
  }
})
}

# EventBridge Target to link the rule to the Step Functions state machine
resource "aws_cloudwatch_event_target" "sfn_target" {
  rule      = aws_cloudwatch_event_rule.guardduty_high_severity_rule.name
  target_id = "Trigger-EC2-Containment-StateMachine"
  arn       = aws_sfn_state_machine.ec2_containment_sm.arn
}
