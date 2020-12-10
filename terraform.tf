terraform {
  backend "s3" {
    bucket = "devon-coding-demo"
    key    = "webapp/terraform.tfstate"
    region = "ap-south-1"
  }
}