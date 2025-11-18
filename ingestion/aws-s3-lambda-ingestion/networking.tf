# ------------------------------------------------------------------------------
# QUARANTINE SECURITY GROUP
# This security group will be applied to compromised EC2 instances to isolate them.
# ------------------------------------------------------------------------------

# Defines the security group used to isolate compromised EC2 instances.
resource "aws_security_group" "quarantine_sg" {
  name        = "Quarantine-SG"
  description = "Isolates instances by blocking all ingress and egress traffic."

  # This line is critical - it uses the variable from variables.tf
  vpc_id = var.vpc_id

  # Deny all inbound traffic
  ingress = []

  # Deny all outbound traffic
  egress = []

  tags = {
    Name      = "Quarantine-SG"
    Project   = "GVRDC"
    ManagedBy = "Terraform"
  }
}
