resource "aws_iam_role" "default" {
  name = "${var.basename}-dlm_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "dlm.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "default" {
  name = "${var.basename}-dlm_role_policy"
  role = aws_iam_role.default.id

  policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
      {
         "Effect": "Allow",
         "Action": [
            "ec2:CreateSnapshot",
            "ec2:CreateSnapshots",
            "ec2:DeleteSnapshot",
            "ec2:DescribeInstances",
            "ec2:DescribeVolumes",
            "ec2:DescribeSnapshots"
         ],
         "Resource": "*"
      },
      {
         "Effect": "Allow",
         "Action": [
            "ec2:CreateTags"
         ],
         "Resource": "arn:aws:ec2:*::snapshot/*"
      }
   ]
}
EOF

}

resource "aws_dlm_lifecycle_policy" "default" {
  description        = var.description
  execution_role_arn = aws_iam_role.default.arn
  state              = "ENABLED"

  policy_details {
    resource_types = ["VOLUME"]

    schedule {
      name = var.schedule_name

      create_rule {
        interval      = var.create_interval
        interval_unit = var.interval_unit
        times         = var.times
      }

      retain_rule {
        count = var.retain_count
      }

      tags_to_add = {
        SnapshotCreator = "DLM"
      }

      # We want see the name and deployment of the EC2 instance in the snapshots
      copy_tags = true
    }

    target_tags = {
      "dlm-lifecycle-policy": var.target_tag_value
    }
  }
}
