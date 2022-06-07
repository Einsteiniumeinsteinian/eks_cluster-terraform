resource "aws_eks_node_group" "einstein-node-ec2" {
  cluster_name    = aws_eks_cluster.einsteinCluster.name
  node_group_name = "${var.eksCluster.name}-${var.nodeGroup.node_group_type}-node_group"
  node_role_arn   = aws_iam_role.einstein_nodeGroup_role.arn
  subnet_ids      = flatten( module.aws_vpc.private_subnets_id )

  scaling_config {
    desired_size = var.nodeGroup.desired_size
    max_size     = var.nodeGroup.max_size
    min_size     = var.nodeGroup.min_size
  }

  ami_type       = var.nodeGroup.ami_type
  instance_types = var.nodeGroup.instance_types
  capacity_type  = var.nodeGroup.capacity_type
  disk_size      = var.nodeGroup.disk_size

  depends_on = [
    aws_iam_role_policy_attachment.einstein-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.einstein-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.einstein-AmazonEKS_CNI_Policy
  ]
}