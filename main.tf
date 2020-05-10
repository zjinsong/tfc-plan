provider "aws" {
  version = "2.33.0"
  region = var.aws_region
}

   resource "aws_lambda_function" "example" {
   function_name = "my-function-tf"
   role= "arn:aws-cn:iam::326449571384:role/lambda-s3-execution-role"
   # The bucket name as created earlier with "aws s3api create-bucket"
   s3_bucket = "repo-lambda"
   s3_key    = "/lambda-test.zip"

   # "main" is the filename within the zip file (main.js) and "handler"
   # is the name of the property under which the handler function was
   # exported in that file.
   handler = "lambda_function.lambda_handler"
   runtime = "python2.7"
 }

 # IAM role which dictates what other AWS services the Lambda function
 # may access.
 resource "aws_iam_role" "lambda_exec" {
   name = "lambda-s3-execution-role"

   assume_role_policy = <<EOF
 {
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {
         "Service": "lambda.amazonaws.com"
       },
       "Effect": "Allow",
       "Sid": ""
     }
   ]
 }
 EOF

 }
