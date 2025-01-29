resource "aws_iam_role" "eks-role" {
    name = "${var.cluster_name}-role"
    assume_role_policy = jsonencode({
        version = "2012-10-17"
        statement = [
        {
           Action = "sts.AssumeRole"
           Effect = "Allow"
           Principal =  {
             Service = "eks.amazonaws.com"
           }
        }]
    })
  
}
resource "aws_iam_role_policy_attachment" "eks-cluster-policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role = aws_iam_role.eks-role.name  
}

resource "aws_iam_role" "eks-node-group-role" {
    name = "${var.cluster_name}-node-group-role"
    assume_role_policy = jsonencode({
        version = "2012-10-17"
        statement = [
        {
           Action = "sts.AssumeRole"
           Effect = "Allow"
           Principal =  {
             Service = "ec2.amazonaws.com"
           }
        }]
    })
  
}
resource "aws_iam_role_policy_attachment" "eks-node-group-policy" {
    for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ])

  policy_arn = each.value
  role       = aws_iam_role.eks-node-group-role.name
}
