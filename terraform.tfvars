# Override default variable values here
region          = "us-east-1"
cluster_name    = "apps-eks-cluster"
vpc_cidr        = "10.0.0.0/16"
cluster_version = "1.27"

# Subnet Configuration
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

# Node group configuration
instance_types = ["t3.medium"]
node_group_name = "apps-eks-node-group"
node_group_desired_size = 1
node_group_max_size     = 1
node_group_min_size     = 1
