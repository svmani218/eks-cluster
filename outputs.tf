output "cluster_endpoint" {
    description = "Cluster endpoint"
    value = aws_eks_cluster.eks-cluster.endpoint  
}
output "cluster_name" {
  description = "cluster name"
  value = aws_eks_cluster.eks-cluster.name
}
output "cluster_authority_data" {
  description = "cluster CA"
  value = aws_eks_cluster.eks-cluster.certificate_authority[0].data
}

output "vpc_id" {
  description = "VPC Id"
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value = aws_subnet.public[*].id
}
output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value = aws_subnet.private[*].id
}