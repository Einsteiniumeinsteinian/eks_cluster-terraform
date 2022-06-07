
module "aws_vpc" {
  source = "github.com/Einsteiniumeinsteinian/vpc-module-terraform"
}


resource "aws_eks_cluster" "einsteinCluster" {
  name     = "${var.eksCluster.name}_cluster"
  role_arn = aws_iam_role.einstein_eksCluster_role.arn
  version  = var.eksCluster.version

  vpc_config {
    subnet_ids          = flatten([ module.aws_vpc.public_subnets_id, module.aws_vpc.private_subnets_id ])
    security_group_ids  = flatten(module.aws_vpc.security_groups_id)
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.einstein_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.einstein_AmazonEKSVPCResourceController,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.einsteinCluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.einsteinCluster.certificate_authority[0].data
}