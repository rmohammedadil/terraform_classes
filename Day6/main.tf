provider "aws" {
  region = "us-east-1"
}

variable "bucket_perfix" {
  description = "unique name for lab bukcets"
  type        = string
  default     = "terraform-class-demo-for-each-1234abcd"
}

# variable "Environment" {
#     description = "Evnironment names for buckets"
#     type = set(string)

#     default = [ "dev", "test", "logs", "stage" ]  
# }


# resource "aws_s3_bucket" "demo" {
#     for_each = var.Environment

#     bucket = "${var.bucket_perfix}-${each.key}"

#     tags = {
#         Evnironment = each.key
#         createdBy = "Adil"    
#     } 
# }

# output "bucket_names" {
#     value = [for bucket in aws_s3_bucket.demo : bucket.bucket]

# }




# variable "buckets" {
#     type = map(string)

#     default = {
#       "dev" = "application-development"
#       "test" = "application-testing"
#       "logs" = "applications-logs"
#     }
# }


variable "bucket" {
  type = map(object(
    {
      Environment = string
      purpose     = string

    }
  ))
  default = {
    dev = {
      Environment = "development"
      purpose     = "Applications files"

    }
    logs = {
      Environment = "shared"
      purpose     = "Applications logs"
    }
  }
}






resource "aws_s3_bucket" "demo-map" {
  for_each = var.bucket

  bucket = "${var.bucket_perfix}-${each.value}"

  tags = {
    Environment = each.value.Environment
    purpose     = each.value.purpose
  }

}

output "bucket_names_map" {
  value = {
    for key, bucket in aws_s3_bucket.demo-map : key => bucket.bucket
  }

}