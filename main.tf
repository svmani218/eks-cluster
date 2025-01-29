resource "aws_eks_cluster" "eks-cluster" {
    name = var.cluster_name
    role_arn = aws_iam_role.eks-role.arn
    version = var.cluster_version
    vpc_config {
      subnet_ids = concat(aws_subnet.public[*].id,aws_subnet.private[*].id)
    }
    depends_on = [ aws_iam_role_policy_attachment.eks-cluster-policy ]
  
}
resource "aws_eks_node_group" "node-group" {
    cluster_name = aws_eks_cluster.eks-cluster.name
    node_group_name = var.node_group_name
    node_role_arn = aws_iam_role.eks-node-group-role.arn
    subnet_ids = aws_subnet.private[*].id
    scaling_config {
      desired_size = var.node_group_desired_nodes
      max_size = var.node_group_max_nodes
      min_size = var.node_group_min_nodes
    }
    instance_types = var.instance_types
    depends_on = [ aws_iam_role_policy_attachment.eks-node-group-policy ]
  
}