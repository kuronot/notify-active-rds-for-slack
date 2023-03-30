
#aws providar Default
provider "aws" {
  region  = "ap-northeast-1"

}
#aws providar Default
provider "aws" {
  alias   = "regional"
  region  = "ap-northeast-1"

}
#aws providar CloudFront
provider "aws" {
  alias   = "global"
  region  = "us-east-1"

}

terraform {
  required_providers {
    awscc = {
      source  = "hashicorp/awscc"
    }
  }
}

# Configure the AWS Provider
provider "awscc" {
  region = "ap-northeast-1"
}
