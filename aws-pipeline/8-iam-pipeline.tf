#------------------------------------------------------------------------------
resource "aws_iam_role" "iam-role-codepipeline" {
  name = "${local.default_name}-iam-role-codepipeline"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
#------------------------------------------------------------------------------
resource "aws_iam_role_policy" "iam-role-policy-codepipeline" {
  name = "${local.default_name}-iam-role-policy-codepipeline"
  role = aws_iam_role.iam-role-codepipeline.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:PassRole"
      ],
      "Resource": "*",
      "Effect": "Allow",
      "Condition": {
          "StringEqualsIfExists": {
          "iam:PassedToService": [
          "cloudformation.amazonaws.com",
          "elasticbeanstalk.amazonaws.com",
          "ec2.amazonaws.com",
          "ecs-tasks.amazonaws.com"
          ]
        }
      }
    },
    {
      "Effect":"Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetBucketVersioning",
        "s3:PutObjectAcl",
        "s3:PutObject"
      ],
      "Resource": [
        "${aws_s3_bucket.s3-bucket-codepipeline.arn}",
        "${aws_s3_bucket.s3-bucket-codepipeline.arn}/*"
      ]
    },
    {
      "Effect":"Allow",
      "Action": [
        "kms:DescribeKey",
        "kms:GenerateDataKey*",
        "kms:Encrypt",
        "kms:ReEncrypt*",
        "kms:Decrypt"
      ],
      "Resource": [
        "${aws_kms_key.kms-key.arn}"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
#------------------------------------------------------------------------------