terraform {
  backend "s3" {
    bucket = "terraform-state-alura-gustavo"
    key    = "Prod/terraform.tfstate"
    region = "us-east-1"
  }
}