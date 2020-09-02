terraform {
  required_version = "~>0.13"
  required_providers {
    aws = {
      version = "3.4.0"
    }
  }
  backend "remote" {
    organization = "hashicorp-team-da-beta"
    workspaces {
      name = "hcp-consul-feedback"
    }
  }
}

provider "aws" {
  region = var.region
}