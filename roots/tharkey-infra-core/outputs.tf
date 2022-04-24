resource "local_file" "kubeconfig" {
  depends_on   = [scaleway_k8s_cluster.cluster]
  filename     = "../../kubeconfig"
  content      = scaleway_k8s_cluster.cluster.kubeconfig.0.config_file
}