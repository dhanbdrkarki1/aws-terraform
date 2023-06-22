resource "aws_s3_bucket" "blog-server-bucket" {
  bucket = var.bucket_name

  versioning = {
    enabled = true
  }

  tags = {
    Name        = "blog-bucket"
    Environment = "Dev"
  }
}


# local file
# resource "null_resource" "local"  {
#   provisioner "local-exec"{
# 	command = "git clone https://github.com/Priyanshi541/HTask2.git C:/Users/user/Desktop/hybrid/htask2/bucketdata"
# }
# }

# #
# resource "aws_s3_bucket" "test-buck" {
#   bucket = "s3-bucket2-25"
#   acl    = "public-read"
 
#   tags = {
#     Name        = "Image_Bucket_25"
#   }
# }


# resource "aws_s3_bucket_object" "object" {
#   bucket = "s3-bucket2-25"
#   key    = "hello.jpg"
#   source="C:/Users/user/Desktop/hybrid/htask2/bucketdata/hello.jpg"
#   content_type = "image/jpeg"
#   acl    = "public-read"
# }