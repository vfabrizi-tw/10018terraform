#credentials
variable "credentials_file" {}
variable "credentials_profile" {}
variable "aws_region" {}

#Tags
variable "project_name" {
  type    = "string"
  default = "prj"
}

variable "service_name" {
  type    = "string"
  default = "sn"
}

variable "environment" {
  type    = "string"
  default = "env"
}

#files
variable "user_data" {
  type    = "string"
  default = ""
}

variable "iam_role" {
  type    = "string"
  default = ""
}

variable "iam_role_policy" {
  type    = "string"
  default = " "
}

variable "uuid" {
  type    = "string"
  default = "1234"
}

