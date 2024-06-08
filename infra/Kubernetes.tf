resource "kubernetes_deployment" "django_api" {

  metadata {
    name = "django"
    labels = {
      name = "django"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        name = "django" #Interligando as duas partes entre metadata e selector
      }
    }

    template {
      metadata {
        labels = {
          name = "django"
        }
      }

      spec {
        container {
          image = "654654371544.dkr.ecr.us-east-1.amazonaws.com/producao:v1"
          name  = "django"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/clientes/"
              port = 8000
            }

            initial_delay_seconds = 30
            period_seconds        = 30
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "LoadBalancer" {
  metadata {
    name = "load-balancer-django-api"
  }
  spec {
    selector = {
      nome = "django"
    }
    port {
      port = 8000
      target_port = 8000
    }
    type = "LoadBalancer"
  }
}

data "kubernetes_service" "nomeDNS" {
    metadata {
      name = "load-balancer-django-api"
    }
}

output "URL" {
  value = data.kubernetes_service.nomeDNS.status
}