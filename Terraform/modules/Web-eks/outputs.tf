output "EKS_CLUSTER_NAME" {
  value = aws_eks_cluster.web-eks.id
}
