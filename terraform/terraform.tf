terraform {
  backend "s3" {
    bucket = "ops-peregrine"
    key    = "terraform/prd-peregrine.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {}
