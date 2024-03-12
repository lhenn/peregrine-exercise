resource "aws_s3_bucket" "prd_peregrine" {
  bucket = "prd-peregrine"

  tags = {
    Name        = "prd-peregrine"
    Environment = "Prd"
  }
}

# TODO: determine why it can't create a bucket in us-east-1
# resource "aws_s3_bucket" "ops_peregrine" {
#   bucket = "ops-peregrine"

#   tags = {
#     Name        = "ops-peregrine"
#     Environment = "Ops"
#   }
# }

