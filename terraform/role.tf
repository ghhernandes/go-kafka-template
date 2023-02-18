# https://docs.aws.amazon.com/msk/latest/developerguide/create-client-iam-role.html
resource "aws_iam_role" "cluster_access" {
  assume_role_policy  = data.aws_iam_policy_document.assume_role.json
  managed_policy_arns = [aws_iam_policy.create_topics.arn]
}
