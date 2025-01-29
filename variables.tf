variable "list1" {
    type = list(string)
    default = [ "one","two","three" ]  
}

variable "cluster_name" {
    description = "EKS cluster name"
    type = string
    default = "apps-k8s"  
}

variable "vpc_name" {
    description = "EKS VPC"
    type = string
    default = "apps-k8s-vpc"  
}

variable "subnet-pub" {
    type = list(string)
    description = "CIDR blocks for public subnets"
    default = [ "10.0.1.0/24","10.0.2.0/24" ]
  
}
variable "subnet-pri" {
    type = list(string)
    description = "CIDR blocks for private subnets"
    default = [ "10.0.3.0/24","10.0.4.0/24" ]
  
}
variable "subnet-zones" {
    type = list(string)
    description = "zones for subnets"
    default = [ "us-east-1a","us-east-1b" ]
  
}

variable "region" {
  type = string
  description = "EKS Deploying region"
  default = "us-east-1"
}
variable "vpc-cidr" {
  type = string
  default = "10.0.0.0/16"
}
variable "cluster_version" {
  type = string
  default = "1.27"
  description = "EKS cluster kubernetes version"
}
variable "node_group_name" {
  type = string
  default = "apps-node-1"
  description = "nodegroup name"
}
variable "node_group_max_nodes" {
    type = number
    default = 1
    description = "Max nodes in the node group"  
}
variable "node_group_min_nodes" {
  type = number
  description = "Min nodes in the node group"
  default = 1
}
variable "node_group_desired_nodes" {
  type = number
  description = "Desired nodes in the node group"
  default = 1
}
variable "instance_types" {
  type = list(string)
  default = [ "t3.medium" ]
  description = "Instance types "
}