terraform {
    required_providers {
       aws = {
          source  = "hashicorp/aws"
          version = "4.38.0"
     }
   }
 }
provider "aws" {
    region = "ap-southeast-2"
}
