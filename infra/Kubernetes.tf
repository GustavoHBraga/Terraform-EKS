resource "kubernetes_deployment" "Django-API" {
  metadata {
    name = "django-api"
    labels = {
      name = "Django"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        name = "Django" #Interligando as duas partes entre metadata e selector
      }
    }

    template {
      metadata {
        labels = {
          name = "Django"
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