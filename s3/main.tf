resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name
}


resource "aws_s3_object" "main" {
 
  for_each = fileset("${path.cwd}/s3/s3_files/", "*")
  bucket = aws_s3_bucket.main.id
  key = each.value
  source = "${path.cwd}/s3/s3_files/${each.value}"

}