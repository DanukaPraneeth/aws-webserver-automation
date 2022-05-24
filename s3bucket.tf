# Create s3 bucket

resource "aws_s3_bucket" "web_bucket" {
  bucket = "bestseller-app-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.web_bucket.id
  acl    = "private"
}


resource "aws_s3_object" "bucket_object" {
  bucket = "bestseller-app-bucket"
  key    = "index.html"
  source = "uploads/index.html"

  depends_on = [
    aws_s3_bucket.web_bucket
  ]

}
