variable "my_region" {
    type = string
    description = "AWS Region"
    default = ""  # Populate with your AWS region
}

variable "account_id" {
  type = string
  description = "AWS Account ID"
  default = ""  # Populate with your AWS account ID (12 digits)
}