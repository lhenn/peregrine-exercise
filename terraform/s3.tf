#
# Example AWS resources using terraform. These are for illustrative purposes and
# are not necessary to complete the prompt but can be created by running
# terraform apply.
#
resource "aws_s3_bucket" "prd_peregrine" {
  bucket = "prd-peregrine"

  tags = {
    Name        = "prd-peregrine"
    Environment = "Prd"
  }
}

resource "aws_s3_bucket_acl" "peregrine_bucket_acl" {
  bucket = aws_s3_bucket.prd_peregrine.id
  acl    = "private"
}
