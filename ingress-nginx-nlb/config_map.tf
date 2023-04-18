resource "kubernetes_config_map" "nginx-configuration" {
  metadata {
    name      = "ingress-nginx-controller"
    annotations = {
        "meta.helm.sh/release-name" = "ingress-nginx"
        "meta.helm.sh/release-namespace" = "kube-system"

    }
    namespace = "kube-system"
    labels = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/instance" = "ingress-nginx"
      "app.kubernetes.io/managed-by" =  "Helm"
      "app.kubernetes.io/name" = "ingress-nginx"
      "app.kubernetes.io/part-of" =  "ingress-nginx"
      "app.kubernetes.io/version" =  "1.6.4"
      "helm.sh/chart" = "ingress-nginx-4.5.2"
    }
  }
  data = {
    "allow-snippet-annotations" = "true"
    "http-snippet" = "limit_req_zone $binary_remote_addr zone=my-zone:20m rate=10r/s;"
  }

}
