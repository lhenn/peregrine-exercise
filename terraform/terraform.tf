# TODO: determine why tf isn't able to access bucket to migrate state
# terraform {
#   backend "s3" {
#     bucket = "ops-peregrine"
#     key    = "terraform/prd-peregrine.tfstate"
#     region = "us-east-1"
#   }
# }

provider "aws" {
  region = "us-east-1"
}
