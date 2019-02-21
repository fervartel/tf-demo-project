/* variable "aws_shared_cred" {
  default = "~/credentials"
} */
variable "aws_profile" {
  default = "default" # Profile name in the shared credentials file (e.g. ~/.aws/credentials)
}
variable "aws_region" {
  default = "us-east-1"
}