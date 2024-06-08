module "prod" {
    source = "../../infra"

    nome_repositorio = "producao"
    cluster_name = "producao"
}

output "Status_DNS" {
  value = module.prod.URL
}