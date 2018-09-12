{
  "Id": "${var.project_name}-${terraform.workspace}-logs-policy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1484671540333",
      "Action": "s3:PutObject",
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.project_name}-${terraform.workspace}-logs/*",
      "Principal": {
        "AWS": "arn:aws:iam::${lookup(var.default_log_account_ids, var.aws_region)}:root"
      }
    }
  ]
}