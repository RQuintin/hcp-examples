terraform {
  required_version = "~>0.13"
  required_providers {
    aws = {
      version = "3.4.0"
    }
  }
  backend "remote" {}
}

provider "aws" {
  region = var.region
}