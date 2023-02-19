# https://docs.aws.amazon.com/msk/latest/developerguide/create-client-iam-role.html
resource "aws_iam_role" "msk_cluster_role" {
  name                = "${var.app_name}-msk-role"
  assume_role_policy  = data.aws_iam_policy_document.instance_assume_role.json
  managed_policy_arns = [aws_iam_policy.create_topics.arn]
}

resource "aws_iam_role" "eks_cluster_role" {
  name               = "${var.app_name}-eks-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role.json
}

resource "aws_iam_role" "eks_fargate_profile_role" {
  name               = "${var.app_name}-eks-fargate-profile-role"
  assume_role_policy = data.aws_iam_policy_document.eks_fargate_profile_assume_role.json
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSFargatePodExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.eks_fargate_profile_role.name
}
