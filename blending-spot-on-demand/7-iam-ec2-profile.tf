#------------------------------------------------------------------
resource "aws_iam_role" "EC2InstanceRole" {
  name               = "${local.default_name}-EC2InstanceRole"
  path               = "/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

  tags = {
    "Name"        = "${local.default_name}-EC2InstanceRole"
    "Description" = "EC2InstanceRole role for tutorial"
  }
}
#------------------------------------------------------------------
resource "aws_iam_policy_attachment" "EC2RoleforAWSCodeDeploy-policy-attachment" {
  name       = "${local.default_name}-EC2RoleforAWSCodeDeploy-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
  groups     = []
  users      = []
  roles      = [aws_iam_role.EC2InstanceRole.name]
  depends_on = [aws_iam_role.EC2InstanceRole]
}
#------------------------------------------------------------------
resource "aws_iam_instance_profile" "EC2InstanceRoleProfile" {
  name       = "${local.default_name}-EC2InstanceRoleProfile"
  role       = aws_iam_role.EC2InstanceRole.name
  depends_on = [aws_iam_role.EC2InstanceRole]
}
#------------------------------------------------------------------